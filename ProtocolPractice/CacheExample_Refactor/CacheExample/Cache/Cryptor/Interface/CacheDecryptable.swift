//
//  CacheDecryptable.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol CacheDecryptable {
    func decrypt(_ data: Data, cryptKey: CacheCryptKeyType) throws -> Data
}
