//
//  BaseNavigationControllerDelegate.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 13/09/2023.
//

import Foundation
import UIKit

protocol BaseNavigationControllerDelegate: NSObjectProtocol {
    func setNavigationBarAppearance()
}

extension BaseNavigationControllerDelegate where Self: UINavigationController {
    func setNavigationBarAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)]
            navigationBar.standardAppearance = appearance
        } else {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
        }
        UINavigationBar.appearance().tintColor = UIColor.getColor(.secondary)
        addShadow()
        setBackButton()
    }
}

private extension UINavigationController {

    func addShadow() {
        self.addCustomBottomLine(color: UIColor.white, height: 1)
        self.navigationBar.addShadow(shadowOpacity: 0.16,
                                     shadowColor: .black,
                                     shadowRadius: 2,
                                     shadowOffset: .init(width: 0, height: 1))
    }

    func setBackButton() {
        let back = UIImage(systemName: "chevron.left")
        if #available(iOS 15.0, *) {
            navigationBar.standardAppearance.setBackIndicatorImage(back, transitionMaskImage: nil)
        } else {
            navigationBar.backIndicatorImage = back
        }
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.getColor(.darkGrey)],
                                                            for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.getColor(.darkGrey)],
                                                            for: .highlighted)
        UINavigationBar.appearance().tintColor = UIColor.getColor(.darkGrey)
    }

    func addCustomBottomLine(color: UIColor, height: Double) {
        // Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")

        // Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}

