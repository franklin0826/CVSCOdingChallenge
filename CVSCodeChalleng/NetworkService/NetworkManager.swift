//
//  NetworkManager.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation

protocol NetworkAction {
    func get<T: Decodable>(apiURL: String, type: T.Type) async throws -> T
}

struct NetworkManager {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkAction, JsonDecoder {
    func get<T>(apiURL: String, type: T.Type) async throws -> T where T : Decodable {
        guard let url = URL(string: apiURL) else {
            throw APIError.urlError
        }
       let (data, _) = try await urlSession.data(from: url)
       return try decode(type:type, data: data)
    }
}
