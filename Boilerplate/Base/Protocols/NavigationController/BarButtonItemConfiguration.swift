//
//  BarButtonItemConfiguration.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 13/09/2023.
//

import Foundation
import UIKit

enum BarButtonItemPosition {
    case right, left
}

enum BarButtonItemType {
    case search(BarButtonItemPosition)
    case notification(BarButtonItemPosition, Int)
}

/// Has default implementation on UIViewControllers that conform to BarButtonActions.
protocol BarButtonItemConfiguration: NSObjectProtocol {
    func addBarButtonItem(ofType type: BarButtonItemType)
}

/// Hate that we're forced to expose button targets to objc runtime :(
/// but I don't know any other way for the time being, maybe in Swift 6 :)
@objc protocol BarButtonActions {
    @objc optional func showSearchConroller(_ sender: AnyObject)
    @objc optional func showNotificationController(_ sender: AnyObject)
}

extension BarButtonItemConfiguration where Self: UIViewController, Self: BarButtonActions {

    func addBarButtonItem(ofType type: BarButtonItemType) {

        func newButton(image: UIImage?, position: BarButtonItemPosition, action: Selector, badgeCount: Int = 0) {

            let button = UIButton(type: .custom)
//            button.tintColor = UIColor.getColor(.secondary)
            button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: action, for: .touchUpInside)

            if badgeCount > 0 {
                let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
                lblBadge.backgroundColor = .red
                lblBadge.clipsToBounds = true
                lblBadge.layer.cornerRadius = 7
                lblBadge.textColor = UIColor.white
                lblBadge.textAlignment = .center
                lblBadge.text = "\(badgeCount)"
                button.addSubview(lblBadge)
            }

            let barButtonItem = UIBarButtonItem(customView: button)
            let currWidth = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 30)
            currWidth?.isActive = true
            let currHeight = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 25)
            currHeight?.isActive = true

            switch position {
            case .left:
                if self.navigationItem.leftBarButtonItems?.isEmpty ?? true {
                    self.navigationItem.leftBarButtonItem = barButtonItem
                } else {
                    self.navigationItem.leftBarButtonItems?.append(barButtonItem)
                }
            case .right:
                if self.navigationItem.rightBarButtonItems?.isEmpty ?? true {
                    self.navigationItem.rightBarButtonItem = barButtonItem
                } else {
                    self.navigationItem.rightBarButtonItems?.append(barButtonItem)
                }
            }
        }

        switch type {
        case .search(let position):
            newButton(image: UIImage.init(systemName: "magnifyingglass"),
                      position: position,
                      action: #selector(Self().showSearchConroller(_:)))
        case .notification(let position, let count):
            self.navigationItem.rightBarButtonItems = []
            newButton(image: UIImage.init(systemName: "bell.fill"),
                      position: position,
                      action: #selector(Self().showNotificationController(_:)),
                      badgeCount: count)
        }
    }
}

/// Conform to this in subclasses of UIViewController and implement BarButtonActions (its impl. differs from vc to vc).
typealias BarButtonConfigarable = BarButtonItemConfiguration & BarButtonActions
