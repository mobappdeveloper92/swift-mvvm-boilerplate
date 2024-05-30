//
//  Storyboard.swift
//  Ecommerce
//
//  Created by Faizan Mahmood on 18/05/2022.
//

import Foundation
import UIKit

enum Storyboard: String {
    case splash = "Splash"
    case auth = "Auth"
    case posts = "posts"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T: UIViewController> (viewControllerClass: T.Type) -> T {
        let storyboardID  = (viewControllerClass as UIViewController.Type).storyboardID
        // swiftlint:disable force_cast
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(from storyboard: Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
}
