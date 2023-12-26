//
//  UserServiceProtocol.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

protocol UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
