//
//  JSONNetworkSerializer.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

struct JSONNetworkSerializer: NetworkSerializable {

    // MARK: - Public

    func serialize(_ parameters: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters)
    }
}
