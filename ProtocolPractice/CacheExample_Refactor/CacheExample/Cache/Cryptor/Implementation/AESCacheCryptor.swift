//
//  AESCacheCryptor.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation
import CryptoKit

struct AESCacheCryptor: CacheEncryptable, CacheDecryptable {

    // MARK: - Public

    func encrypt(_ data: Data, cryptKey: CacheCryptKeyType) throws -> Data {
        guard let keyData = cryptKey.key else { return data }
        guard let nonceData = cryptKey.nonce else { return data }

        let sealedBox = try AES.GCM.seal(
            data,
            using: .init(data: keyData),
            nonce: .init(data: nonceData)
        )
        return sealedBox.ciphertext + sealedBox.tag
    }

    func decrypt(_ data: Data, cryptKey: CacheCryptKeyType) throws -> Data {
        guard let keyData = cryptKey.key else { return data }
        guard let nonceData = cryptKey.nonce else { return data }

        let sealedBox = try AES.GCM.SealedBox(
            nonce: .init(data: nonceData),
            ciphertext: data.dropLast(16),
            tag: data.suffix(16)
        )
        return try AES.GCM.open(sealedBox, using: .init(data: keyData))
    }
}
