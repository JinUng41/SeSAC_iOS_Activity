//
//  User.swift
//  NetworkExample
//
//  Created by kawoou on 2023/02/10.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let accesstoken: String
}
