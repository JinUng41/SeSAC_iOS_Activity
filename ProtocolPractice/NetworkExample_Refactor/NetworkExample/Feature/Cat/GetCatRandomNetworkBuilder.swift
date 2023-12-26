//
//  GetCatRandomNetworkBuilder.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

struct GetCatRandomNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = CatImageURL

    var path: String { "v1/cat/random" }
    var parameters: [String: Any] { [:] }
    let deserializer: NetworkDeserializable = PropertyListNetworkDeserializer(
        decoder: PropertyListDecoder()
    )
    var useAuthorization: Bool { true }
}
