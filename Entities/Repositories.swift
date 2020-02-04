//
//  Repositories.swift
//  Entities
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Repositories: Codable {
    public let totalCount: Int
    public let items: [Repository]

    public enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }

}
