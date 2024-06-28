//
//  APIError.swift
//  CVSCodeChalleng
//
//  Created by Franklin Mott on 28/06/24.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case urlError
    case serverNotFoundError
    case dataNotFound
}
