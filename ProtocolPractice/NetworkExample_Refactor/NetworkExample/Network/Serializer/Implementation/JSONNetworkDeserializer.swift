//
//  JSONNetworkDeserializer.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

struct JSONNetworkDeserializer: NetworkDeserializable {

    // MARK: - Private property

    private let decoder: JSONDecoder

    // MARK: - Lifecycle

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    // MARK: - Public

    func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
