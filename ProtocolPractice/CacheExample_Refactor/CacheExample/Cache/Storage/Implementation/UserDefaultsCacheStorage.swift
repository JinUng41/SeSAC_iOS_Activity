//
//  UserDefaultsCacheStorage.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class UserDefaultsCacheStorage: CacheStorageProtocol {

    // MARK: - Private property

    private let userDefaults: UserDefaults

    // MARK: - Lifecycle

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    func load(for key: String) -> Data? {
        userDefaults.data(forKey: key)
    }

    func save(_ data: Data, for key: String) {
        userDefaults.set(data, forKey: key)
    }
}
