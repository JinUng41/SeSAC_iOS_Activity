//
//  Cache.swift
//  CacheExample
//
//  Created by kawoou on 2023/02/10.
//

import Foundation
import CryptoKit

final class Cache {

    // MARK: - Private property

    private let storage: CacheStorageProtocol
    private let encryptor: CacheEncryptable?
    private let decryptor: CacheDecryptable?

    private let cryptKey: CacheCryptKeyType

    // MARK: - Lifecycle

    init(
        storage: CacheStorageProtocol,
        encryptor: CacheEncryptable?,
        decryptor: CacheDecryptable?,
        cryptKey: CacheCryptKeyType
    ) {
        self.storage = storage
        self.encryptor = encryptor
        self.decryptor = decryptor

        self.cryptKey = cryptKey
    }

    // MARK: - Public

    func get(for key: String) -> Data? {
        let cacheKey = makeCacheKey(key)
        guard let originalData = storage.load(for: cacheKey) else { return nil }

        if let decryptor {
            return try? decryptor.decrypt(originalData, cryptKey: cryptKey)
        } else {
            return originalData
        }
    }

    func store(_ value: Data, for key: String) throws {
        let cacheKey = makeCacheKey(key)
        let encryptedData: Data = try {
            if let encryptor {
                return try encryptor.encrypt(value, cryptKey: cryptKey)
            } else {
                return value
            }
        }()

        storage.save(encryptedData, for: cacheKey)
    }

    // MARK: - Private

    private func makeCacheKey(_ key: String) -> String {
        "cache_\(key)"
    }
}
