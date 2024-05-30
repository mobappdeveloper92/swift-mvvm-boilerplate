//
//  SplashViewController.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 13/09/2023.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigate()
    }

    private func navigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.authNavigator?.navigate(to: .login)
        }
    }
}
