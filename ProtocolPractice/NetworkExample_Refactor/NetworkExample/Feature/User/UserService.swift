//
//  UserService.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class UserService: UserServiceProtocol {

    // MARK: - Private property

    private let accesstokenStorage: AccesstokenStorable
    private let networkManager: NetworkManager

    // MARK: - Lifecycle

    init(
        accesstokenStorage: AccesstokenStorable,
        networkManager: NetworkManager
    ) {
        self.accesstokenStorage = accesstokenStorage
        self.networkManager = networkManager
    }

    // MARK: - Public

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let builder = UserLoginNetworkBuilder(email: email, password: password)

        networkManager.request(builder) { [accesstokenStorage] result in
            if case let .success(user) = result {

            }

            completion(result)
        }
    }
}
