//
//  AuthNavigator.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation
import UIKit

class AuthNavigator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    enum Destination {
        case login
    }

    func navigate(to destination: Destination) {
        let controller = makeController(for: destination)
        controller.hidesBottomBarWhenPushed = true
        switch destination {
        case .login:
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = controller
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = controller
            }
        default:
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}

private extension AuthNavigator {
    func makeController(for destination: Destination) -> BaseViewController {
        switch destination {
        case .login:
            return makeLoginViewController()
        }
    }
}

private extension AuthNavigator {
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController.instantiate(from: .auth)
    }
}
