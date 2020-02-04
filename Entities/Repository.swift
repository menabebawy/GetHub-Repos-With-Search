//
//  Repository.swift
//  Entities
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Repository: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let size: Int
    public let forksCount: Int
    public let stargazersCount: Int
    public let contributorsUrl: String

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case size = "size"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case contributorsUrl = "contributors_url"
    }

}
