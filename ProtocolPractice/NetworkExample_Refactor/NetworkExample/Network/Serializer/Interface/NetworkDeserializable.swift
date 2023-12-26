//
//  NetworkDeserializable.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol NetworkDeserializable {
    func deserialize<T: Decodable>(_ data: Data) throws -> T
}
