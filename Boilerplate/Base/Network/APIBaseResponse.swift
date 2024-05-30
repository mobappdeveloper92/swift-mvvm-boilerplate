//
//  APIBaseResponse.swift
//  TestCasesDemo
//
//  Created by Faizan Mahmood on 05/09/2023.
//

import Foundation

typealias Parameters = [String: Any]

typealias ResponseCompletion<T: Codable> = ((_ response: APIBaseResponse<T>?, _ error: String?) -> Void)

struct APIBaseResponse<ResponseData: Codable>: Codable {
    let status: Bool
    let statusCode: Int
    let message: String
    let data: ResponseData?

    func getStatus() -> APIStatusCode {
        return APIStatusCode.init(rawValue: statusCode) ?? .unknown
    }
}

enum APIStatusCode: Int, Codable {
    case success = 1
    case userAlreadyExists = 2
    case userNotFound = 3
    case sessionExpired = 4
    case unauthorized = 5
    case badRequest = 6
    case deviceNotRegistered = 7
    case invalidOTP = 8
    case unableToResendOTP = 9
    case anErrorOccurred = 10
    case partnerNotFound = 11
    case passwordNotMatched = 12
    case memberNotFound = 13
    case couponNotFound = 14
    case unknown
}
