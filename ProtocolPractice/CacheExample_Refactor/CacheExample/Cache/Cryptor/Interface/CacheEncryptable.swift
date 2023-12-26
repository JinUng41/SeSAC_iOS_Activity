//
//  CacheEncryptable.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol CacheEncryptable {
    func encrypt(_ data: Data, cryptKey: CacheCryptKeyType) throws -> Data
}
