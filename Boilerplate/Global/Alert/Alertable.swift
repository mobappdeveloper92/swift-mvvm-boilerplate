//
//  Alertable.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import UIKit

public protocol Alertable {}

public extension Alertable where Self: UIViewController {

    internal func showAlert(title: String?, message: String?,
                            btnOkayTitle: String? = "OK", btnCancelTitle: String? = "Cancel",
                            btnOkeyHandler: ((UIAlertAction) -> Void)? = nil, btnCancelHandler: ((UIAlertAction) -> Void)? = nil,
                            isAlert: Bool = true, style: UIAlertController.Style = .alert) {

        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)

        let okActoin = UIAlertAction(title: btnOkayTitle, style: .default, handler: btnOkeyHandler)
        alertController.addAction(okActoin)

        if !isAlert {
            let cancelActoin = UIAlertAction(title: btnCancelTitle, style: .default, handler: btnCancelHandler)
            alertController.addAction(cancelActoin)
        }

        present(alertController, animated: true, completion: nil)
    }
}
