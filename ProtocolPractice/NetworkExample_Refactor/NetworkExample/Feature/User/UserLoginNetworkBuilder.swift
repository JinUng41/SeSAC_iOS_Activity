//
//  UserLoginNetworkBuilder.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

struct UserLoginNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = User

    var path: String { "v1/user/login" }
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(
        decoder: JSONDecoder()
    )
    var useAuthorization: Bool { false }

    init(email: String, password: String) {
        self.parameters = [
            "email": email,
            "password": password
        ]
    }
}
