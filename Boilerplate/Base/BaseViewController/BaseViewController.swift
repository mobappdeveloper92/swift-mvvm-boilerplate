//
//  BaseViewController.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 15/04/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, Alertable, Loadable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(String(describing: self)) loaded")
    }

    deinit {
        print("deinit \(String(describing: self))")
    }

    func showErrorAlert(_ message: String) {
        showAlert(title: "Error!", message: message)
    }
}
