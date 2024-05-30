//
//  LoginViewModel.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation

protocol LoginViewModelDelegate: NSObjectProtocol {
    func didLoginSuccessfully()
    func showNotLoginError(error: String)
}

protocol LoginViewModel: ViewModelType {
    func login(email: String, password: String)
}

final class LoginViewModelImp: LoginViewModel {

    private var interactor: AuthInterActor?
    weak var delegate: LoginViewModelDelegate?

    init(interactor: AuthInterActor?, delegate: LoginViewModelDelegate? = nil) {
        self.interactor = interactor
        self.delegate = delegate
    }

    func login(email: String, password: String) {
        let request = LoginRequest.init(email: email, password: password)
        interactor?.login(request: request, completion: { [weak self] response, error in
            self?.delegate?.didLoginSuccessfully()
//            if let error = error {
//                self?.delegate?.showNotLoginError(error: error)
//            } else {
//                AppDefaults.user = response?.data
//                self?.delegate?.didLoginSuccessfully()
//            }
        })
    }
}
