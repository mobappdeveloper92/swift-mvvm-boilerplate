//
//  AppDelegate.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 15/04/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeDependencies(with: application, and: launchOptions)
        return true
    }
}

// MARK: - Dependencies
private extension AppDelegate {
    func initializeDependencies(with application: UIApplication, and launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        LanguageManager.shared.defaultLanguage = .deviceLanguage
        configureIQKeyboardManager()
    }

    func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .getColor(.primary)
    }
}
