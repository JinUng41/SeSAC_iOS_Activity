//
//  NetworkError.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

enum NetworkError: Error {
    case notFoundBaseURL

    case responseNotFound
    case imageDecodingFailure
}
