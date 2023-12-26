//
//  BaseURLRegistrable.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol BaseURLRegistrable {
    func register(_ url: URL, for type: BaseURLType)
}
