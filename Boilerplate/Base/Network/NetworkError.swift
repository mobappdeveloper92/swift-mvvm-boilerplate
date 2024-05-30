//
//  NetworkError.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString(
                "The response is not valid.",
                comment: "Invalid Response"
            )
        }
    }
}
