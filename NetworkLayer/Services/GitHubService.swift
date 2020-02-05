//
//  PostService.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

public enum GitHubService: ServiceProtocol {
    
    case repository(id: Int)
    case repositories(searchText: String, pageIndex: Int)
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    public var path: String {
        switch self {
        case let .repository(id):
            return "repositories/\(id)"
        case .repositories:
            return "search/repositories"
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .repository:
            return .requestPlain
        case .repositories(let searchText, let pageIndex):
            let parameters: KeyValuePairs<String, Any> = ["q": searchText,
                                                          "order": "desc",
                                                          "page": pageIndex]
            return .requestParameters(parameters)
        }
    }
    
    public var headers: Headers? {
        return nil
    }
    
    public var parametersEncoding: ParametersEncoding {
        return .url
    }

}
