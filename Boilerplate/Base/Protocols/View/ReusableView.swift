//
//  ReusableView.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 20/04/2022.
//

import UIKit

protocol ReusableView { }

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
