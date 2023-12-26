//
//  CacheCryptKeyType.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

enum CacheCryptKeyType {
    case none
    case aes
}

extension CacheCryptKeyType {
    var key: Data? {
        switch self {
        case .none:
            return nil
        case .aes:
            return "164e0d602db8cae3d0b886cc7a60e415".data(using: .utf8)!
        }
    }

    var nonce: Data? {
        switch self {
        case .none:
            return nil
        case .aes:
            return "3kdmfjkekaskjahe132kluh".data(using: .utf8)!
        }
    }
}
