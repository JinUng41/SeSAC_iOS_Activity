//
//  NetworkSession.swift
//  NetworkExample
//
//  Created by kawoou on 2023/11/28.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {

    // MARK: - Private property

    private let session: URLSession

    // MARK: - Lifecycle

    init(session: URLSession) {
        self.session = session
    }

    // MARK: - Public

    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<NetworkResponse, Error>) -> Void
    ) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let response = response else {
                completionHandler(.failure(NetworkError.responseNotFound))
                return
            }

            completionHandler(.success(NetworkResponse(response: response, data: data)))
        }
        task.resume()
    }
}
