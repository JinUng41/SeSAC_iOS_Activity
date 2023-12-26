//
//  NetworkManager.swift
//  NetworkExample
//
//  Created by kawoou on 2023/02/10.
//

import Foundation

enum NetworkError: Error {
    case responseNotFound
    case imageDecodingFailure
}

final class NetworkManager {

    // MARK: - Constants

    struct Constants {
        static let baseURL = URL(string: "https://example.com/")!
    }

    // MARK: - Static

    static let shared = NetworkManager()

    // MARK: - Private property

    private var accesstoken: String?

    // MARK: - Lifecycle

    private init() {}

    // MARK: - Public

    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        request(
            url: Constants.baseURL.appendingPathComponent("v1/user/login"),
            headers: [:],
            parameters: [
                "email": email,
                "password": password
            ],
            successHandler: { [weak self] (response, data) in
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    self?.accesstoken = user.accesstoken
                    completion(.success(user))
                } catch let error {
                    completion(.failure(error))
                }
            },
            errorHandler: { error in
                completion(.failure(error))
            }
        )
    }

    func getCatRandom(completion: @escaping (Result<String, Error>) -> Void) {
        request(
            url: Constants.baseURL.appendingPathComponent("v1/cat/random"),
            headers: [
                "Authorization": "Bearer \(accesstoken ?? "")"
            ],
            parameters: [:],
            successHandler: { (response, data) in
                do {
                    let catImageURL = try PropertyListDecoder().decode(CatImageURL.self, from: data)
                    completion(.success(catImageURL.url))
                } catch let error {
                    completion(.failure(error))
                }
            },
            errorHandler: { error in
                completion(.failure(error))
            }
        )
    }

    func getCatSingle(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        request(
            url: Constants.baseURL.appendingPathComponent("v1/cat/\(id)"),
            headers: [
                "Authorization": "Bearer \(accesstoken ?? "")"
            ],
            parameters: [:],
            successHandler: { (response, data) in
                do {
                    let catImageURL = try PropertyListDecoder().decode(CatImageURL.self, from: data)
                    completion(.success(catImageURL.url))
                } catch let error {
                    completion(.failure(error))
                }
            },
            errorHandler: { error in
                completion(.failure(error))
            }
        )
    }

    // MARK: - Private

    private func request(
        url: URL,
        headers: [String: String],
        parameters: [String: Any],
        successHandler: ((URLResponse, Data) -> Void)?,
        errorHandler: ((Error) -> Void)?
    ) {
        do {
            var request = URLRequest(url: url)
            headers.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }
            request.setValue("1.0", forHTTPHeaderField: "X-App-Version")
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    errorHandler?(error)
                    return
                }

                guard let response = response, let data = data else {
                    errorHandler?(NetworkError.responseNotFound)
                    return
                }

                successHandler?(response, data)
            }
            task.resume()
        } catch let error {
            errorHandler?(error)
        }
    }
}
