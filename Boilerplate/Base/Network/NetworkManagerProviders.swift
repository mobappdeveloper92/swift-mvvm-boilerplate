//
//  NetworkManagerProviders.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation
import Alamofire
import Moya

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
//        configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

enum NetworkManagerProviderType<APIType: TargetType> {
    case live, mock

    func getProvider() -> MoyaProvider<APIType> {
        switch self {
        case .live:
            return getLiveProvider()
        case .mock:
            return getMockProvider()
        }
    }
}

private extension NetworkManagerProviderType {
    func getLiveProvider() -> MoyaProvider<APIType> {
        return MoyaProvider<APIType>(session: DefaultAlamofireSession.shared,
                                         plugins: [ NetworkLoggerPlugin(configuration: .init(
                                            formatter: .init(),
                                            output: { _, items in
                                                if let log = items.first {
                                                    print(log)
                                                }},
                                            logOptions: [.formatRequestAscURL]))
                                                  ])
    }

    func getMockProvider() -> MoyaProvider<APIType> {
        return MoyaProvider<APIType>(stubClosure: MoyaProvider<APIType>.delayedStub(1.0),
                                         plugins: [ NetworkLoggerPlugin(configuration: .init(
                                            formatter: .init(),
                                            output: { _, items in
                                                if let log = items.first {
                                                    print(log)
                                                }},
                                            logOptions: [.formatRequestAscURL]))
                                                  ])
    }
}
