//
//  NetworkSessionProtocol.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol NetworkSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<NetworkResponse, Error>) -> Void
    )
}
