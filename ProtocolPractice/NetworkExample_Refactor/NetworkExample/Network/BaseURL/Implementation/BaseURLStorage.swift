//
//  BaseURLStorage.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class BaseURLStorage: BaseURLResolvable, BaseURLRegistrable {

    // MARK: - Private property

    private var baseURLMap: [BaseURLType: URL] = [:]

    // MARK: - Public

    func resolve(for type: BaseURLType) -> URL? {
        baseURLMap[type]
    }

    func register(_ url: URL, for type: BaseURLType) {
        baseURLMap[type] = url
    }
}
