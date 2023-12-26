//
//  BaseURLResolvable.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol BaseURLResolvable {
    func resolve(for type: BaseURLType) -> URL?
}
