//
//  URLSessionProvider.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

public final class URLSessionProvider: ProviderProtocol {
    private var session: URLSessionProtocol
    private var currentTask: URLSessionDataTask!

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func cancelCurrentTask() {
        currentTask.cancel()
    }
    
    public func request<T>(type: T.Type,
                           url: URL,
                           completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(url: url)
        executeRequest(request, completion: completion)
    }

    public func request<T>(type: T.Type,
                           service: ServiceProtocol,
                           completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(service: service)
        executeRequest(request, completion: completion)
        
    }
    
    private func executeRequest<T>(_ request: URLRequest, completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        currentTask = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            do {
                try self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
            } catch {
                completion(.failure(.unknown))
            }
        })
        currentTask.resume()
    }

    private func handleDataResponse<T: Decodable>(data: Data?,
                                                  response: HTTPURLResponse?,
                                                  error: Error?,
                                                  completion: @escaping (NetworkResponse<T>) -> Void) throws {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }

        let nextUrl = try URLSessionProvider.parseNextURL(response)
        DispatchQueue.main.async {
            switch response.statusCode {
            case 200...299:
                guard let data = data,
                    let model = try? JSONDecoder().decode(T.self, from: data) else {
                        return completion(.failure(.unknown))
                }
                completion(.success(models: model, nextUrl: nextUrl))
            default:
                completion(.failure(.unknown))
            }
        }
    }

}

// MARK: - Parsing links

extension URLSessionProvider {
    private static let parseLinksPattern = "\\s*,?\\s*<([^\\>]*)>\\s*;\\s*rel=\"([^\"]*)\""
    private static let linksRegex = try! NSRegularExpression(pattern: parseLinksPattern, options: [.allowCommentsAndWhitespace])

    private static func parseLinks(_ links: String) throws -> [String: String] {

        let length = (links as NSString).length
        let matches = URLSessionProvider.linksRegex.matches(in: links, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: length))

        var result: [String: String] = [:]

        for m in matches {
            let matches = (1 ..< m.numberOfRanges).map { rangeIndex -> String in
                let range = m.range(at: rangeIndex)
                let startIndex = links.index(links.startIndex, offsetBy: range.location)
                let endIndex = links.index(links.startIndex, offsetBy: range.location + range.length)
                return String(links[startIndex ..< endIndex])
            }

            if matches.count != 2 {
                throw NetworkError.parseLinks
            }

            result[matches[1]] = matches[0]
        }
        
        return result
    }

    private static func parseNextURL(_ httpResponse: HTTPURLResponse) throws -> URL? {
        guard let serializedLinks = httpResponse.allHeaderFields["Link"] as? String else {
            return nil
        }

        let links = try URLSessionProvider.parseLinks(serializedLinks)

        guard let nextPageURL = links["next"] else {
            return nil
        }

        guard let nextUrl = URL(string: nextPageURL) else {
            throw NetworkError.parseNextLink(nextPageURL)
        }

        return nextUrl
    }
    
}
