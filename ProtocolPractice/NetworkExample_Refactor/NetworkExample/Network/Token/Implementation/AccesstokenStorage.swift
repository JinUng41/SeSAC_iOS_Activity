//
//  AccesstokenStorage.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class AccesstokenStorage: AccesstokenProvidable, AccesstokenStorable {

    // MARK: - Public property

    var accesstoken: String?

    // MARK: - Public

    func store(_ accesstoken: String?) {
        self.accesstoken = accesstoken
    }
}
