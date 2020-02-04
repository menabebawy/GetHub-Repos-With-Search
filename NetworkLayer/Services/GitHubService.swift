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
    case repositories(pageIndex: Int, perPage: Int)
    case contributors(fullname: String)

    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    public var path: String {
        switch self {
        case let .repository(id):
            return "repositories/\(id)"
        case .repositories:
            return "search/repositories"
        case let .contributors(fullname):
            return "repos/\(fullname)/stats/contributors"
        }
    }

    public var method: HTTPMethod {
        return .get
    }

    public var task: Task {
        switch self {
        case .repository:
            return .requestPlain
        case .repositories(let pageIndex, let perPage):
            let parameters: KeyValuePairs<String, Any> = ["q": "is:public+language:swift",
                                                          "sort": "stars",
                                                          "order": "desc",
                                                          "per_page": perPage,
                                                          "page": pageIndex,
                                                          "rel": "next"]
            return .requestParameters(parameters)
        case .contributors:
            return .requestPlain
        }
    }

    public var headers: Headers? {
        return nil
    }

    public var parametersEncoding: ParametersEncoding {
        return .url
    }
}
