//
//  AuthInteractor.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation

protocol AuthInterActor {
    var networkManager: NetworkManager<AuthAPIs> { get }
    func login(request: LoginRequest, completion: @escaping NetworkMangerCompletion<User>)
}

final class AuthInterActorImp: AuthInterActor {

    var networkManager: NetworkManager<AuthAPIs>

    init() { networkManager = NetworkManager<AuthAPIs>(with: .live) }

    func login(request: LoginRequest, completion: @escaping NetworkMangerCompletion<User>) {
        let target: AuthAPIs = .login(parameters: request.dictionary ?? [:])
        networkManager.request(target: target, completion: completion)
    }
}

final class AuthInterActorMockImp: AuthInterActor {

    var networkManager: NetworkManager<AuthAPIs>

    init() { networkManager = NetworkManager<AuthAPIs>(with: .mock) }

    func login(request: LoginRequest, completion: @escaping NetworkMangerCompletion<User>) {
        let target: AuthAPIs = .login(parameters: request.dictionary ?? [:])
        networkManager.request(target: target, completion: completion)
    }
}
