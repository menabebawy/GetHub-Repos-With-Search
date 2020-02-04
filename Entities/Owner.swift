//
//  Owner.swift
//  Entities
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

public struct Owner: Decodable {
    public let avatarUrl: String
    
    public enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

}
