//
//  AppEnvironment.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class AppEnvironment {

    static let shared = AppEnvironment()

    private(set) lazy var userDefaultsStorage: CacheStorageProtocol = UserDefaultsCacheStorage(
        userDefaults: .standard
    )

    private(set) lazy var aesCryptor: CacheEncryptable & CacheDecryptable = AESCacheCryptor()

    // MARK: - Cache

    private(set) lazy var normalCache: Cache = Cache(
        storage: userDefaultsStorage,
        encryptor: nil,
        decryptor: nil,
        cryptKey: .none
    )

    private(set) lazy var cryptCache: Cache = Cache(
        storage: userDefaultsStorage,
        encryptor: aesCryptor,
        decryptor: aesCryptor,
        cryptKey: .aes
    )

    // MARK: - Screen

    var viewController: ViewController {
        ViewController(
            normalCache: normalCache,
            cryptCache: cryptCache
        )
    }
}
