//
//  Repository.swift
//  Entities
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Repository: Decodable {
    public let id: Int
    public let owner: Owner
    public let name: String
    public let fullName: String
    public let description: String
    public let forksCount: Int
    public let watchersCount: Int

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case name = "name"
        case fullName = "full_name"
        case description = "description"
        case forksCount = "forks_count"
        case watchersCount = "watchers_count"
    }

}
