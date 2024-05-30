//
//  AuthAPIs.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation
import Moya

enum AuthAPIs: TargetType {

    case login(parameters: Parameters)
    case verifyOTP(parameters: Parameters)

    var baseURL: URL {
        return URL.init(string: PlistKey.baseURL.value())!
    }

    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .verifyOTP:
            return "verify-otp"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .verifyOTP:
            return .post
        }
    }

    var sampleData: Data {
        switch self {
        case .login:
            return getFileData(from: "LoginResponse") ?? Data()
        case .verifyOTP:
            return getFileData(from: "LoginResponse") ?? Data()
        }
    }

    var task: Task {
        switch self {
        case .login(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .verifyOTP(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return APIHeader.shared.getHeader()
    }
}
