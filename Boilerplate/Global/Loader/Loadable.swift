//
//  Loadable.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import UIKit

public protocol Loadable {}

public extension Loadable where Self: UIViewController {

    func showLoader(title: String? = nil) {
        ProgressHUD.colorAnimation = UIColor.getColor(.primary)
        ProgressHUD.animate(title, .circleDotSpinFade, interaction: false)
    }

    func dismissLoader() {
        ProgressHUD.dismiss()
    }
}

internal extension Loadable where Self: ViewModelType {

    func showLoader(title: String? = nil) {
        ProgressHUD.colorAnimation = UIColor.getColor(.primary)
        ProgressHUD.animate(title, .circleDotSpinFade, interaction: false)
    }

    func dismissLoader() {
        ProgressHUD.dismiss()
    }
}
