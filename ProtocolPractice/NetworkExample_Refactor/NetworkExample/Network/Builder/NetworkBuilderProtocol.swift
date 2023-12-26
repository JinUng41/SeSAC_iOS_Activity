//
//  NetworkBuilderProtocol.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol NetworkBuilderProtocol {
    associatedtype Response: Decodable

    var baseURL: BaseURLType { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var serializer: NetworkSerializable { get }
    var deserializer: NetworkDeserializable { get }

    var useAuthorization: Bool { get }
}

extension NetworkBuilderProtocol {
    var baseURL: BaseURLType { .api }
    var headers: [String: String] { [:] }

    var serializer: NetworkSerializable {
        JSONNetworkSerializer()
    }
}
