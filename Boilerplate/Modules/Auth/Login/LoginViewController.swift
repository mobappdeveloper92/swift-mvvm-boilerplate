//
//  LoginViewController.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfEmail: FloatingTextField!
    @IBOutlet weak var tfPassword: FloatingTextField!

    private var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareViewModel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tfEmail.text = "aqi101@yopmail.com"
        tfPassword.text = "Test123"
    }

    @IBAction func didTapLogin(_ sender: Any) {
        login()
    }
}

// MARK: - Prepare UI
private extension LoginViewController {
    func prepareUI() {
        prepareTextFields()
    }

    func prepareTextFields() {
        tfEmail.setContent(title: "Email")
        tfEmail.setContentType(.emailAddress, keyboardType: .emailAddress)
        tfPassword.setContent(title: "Password")
        tfPassword.setContentType(.password, keyboardType: .default)
        FloatingTextField.connectFields(fields: [tfEmail, tfPassword])
    }
}

// MARK: - Prepare ViewModel
private extension LoginViewController {
    func prepareViewModel() {
        viewModel = LoginViewModelImp(interactor: AuthInterActorImp(), delegate: self)
    }
}

// MARK: - Helper Functions
private extension LoginViewController {
    func login() {
        guard let email = tfEmail.validatedText(validationType: .email) else { return }
        guard let password = tfPassword.validatedText(validationType: .requiredField(field: "Password")) else { return }
        showLoader()
        viewModel?.login(email: email, password: password)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func didLoginSuccessfully() {
        dismissLoader()
        showAlert(title: "Success!", message: "\(AppDefaults.user?.name ?? ""), you are login successfully.")
    }

    func showNotLoginError(error: String) {
        dismissLoader()
        showErrorAlert(error)
    }
}
