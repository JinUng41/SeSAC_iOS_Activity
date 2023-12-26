//
//  CacheStorageProtocol.swift
//  CacheExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol CacheStorageProtocol {
    func load(for key: String) -> Data?
    func save(_ data: Data, for key: String)
}
