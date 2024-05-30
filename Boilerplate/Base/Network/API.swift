//
//  API.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import Moya

enum API {
    case login(parameters: Parameters)
    case getPosts
}

extension API: TargetType {

    var baseURL: URL {
        let urlString: String = Environment[.baseURL]
        return URL.init(string: urlString)!
    }

    var path: String {
        switch self {
        case .login:
            return "login"
        case .getPosts:
            return "posts"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .getPosts:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .login(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getPosts:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .login:
            return [
                "Accept": "application/json"
            ]
        default:
            return [
                "Accept": "application/json",
                "Authorization": "Bearer \(AppDefaults.token ?? "")"
            ]

        }
    }
}

