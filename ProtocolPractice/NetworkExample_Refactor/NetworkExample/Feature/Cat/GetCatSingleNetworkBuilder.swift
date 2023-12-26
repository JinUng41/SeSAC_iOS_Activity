//
//  GetCatSingleNetworkBuilder.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

struct GetCatSingleNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = CatImageURL

    let path: String
    var parameters: [String: Any] { [:] }
    let deserializer: NetworkDeserializable = PropertyListNetworkDeserializer(
        decoder: PropertyListDecoder()
    )
    var useAuthorization: Bool { true }

    init(id: Int) {
        self.path = "v1/cat/\(id)"
    }
}
