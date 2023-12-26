//
//  NetworkSerializable.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol NetworkSerializable {
    func serialize(_ parameters: [String: Any]) throws -> Data
}
