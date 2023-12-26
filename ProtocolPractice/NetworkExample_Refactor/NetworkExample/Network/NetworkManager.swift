//
//  NetworkManager.swift
//  NetworkExample
//
//  Created by kawoou on 2023/02/10.
//

import Foundation

final class NetworkManager {

    // MARK: - Private property

    private let networkSession: NetworkSessionProtocol
    private let baseURLResolver: BaseURLResolvable
    private let accesstokenProvider: AccesstokenProvidable

    // MARK: - Lifecycle

    init(
        networkSession: NetworkSessionProtocol,
        baseURLResolver: BaseURLResolvable,
        accesstokenProvider: AccesstokenProvidable
    ) {
        self.networkSession = networkSession
        self.baseURLResolver = baseURLResolver
        self.accesstokenProvider = accesstokenProvider
    }

    // MARK: - Public

    func request<Builder: NetworkBuilderProtocol>(
        _ builder: Builder,
        completion: @escaping (Result<Builder.Response, Error>) -> Void
    ) {
        do {
            let request = try makeRequest(builder)
            networkSession.dataTask(with: request) { result in
                switch result {
                case let .success(response):
                    do {
                        let response: Builder.Response = try builder.deserializer.deserialize(response.data ?? Data())
                        completion(.success(response))
                    } catch let error {
                        completion(.failure(error))
                    }

                case let .failure(error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    // MARK: - Private

    private func makeRequest<Builder: NetworkBuilderProtocol>(_ builder: Builder) throws -> URLRequest {
        guard let baseURL = baseURLResolver.resolve(for: builder.baseURL) else {
            throw NetworkError.notFoundBaseURL
        }

        let url = baseURL.appendingPathComponent(builder.path)

        var request = URLRequest(url: url)
        builder.headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        if builder.useAuthorization {
            request.setValue(
                "Bearer \(accesstokenProvider.accesstoken ?? "")",
                forHTTPHeaderField: "Authorization"
            )
        }
        request.setValue("1.0", forHTTPHeaderField: "X-App-Version")
        request.httpBody = try builder.serializer.serialize(builder.parameters)
        return request
    }
}
