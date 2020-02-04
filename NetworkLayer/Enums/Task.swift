//
//  Task.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 06/09/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

public typealias Parameters = KeyValuePairs<String, Any>

public enum Task {
    case requestPlain
    case requestParameters(Parameters)
}
