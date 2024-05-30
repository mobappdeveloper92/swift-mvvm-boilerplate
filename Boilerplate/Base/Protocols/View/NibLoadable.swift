//
//  NibLoadable.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 20/04/2022.
//

import UIKit

protocol NibLoadable { }

extension NibLoadable where Self: UIView {

    static var NibName: String {
        return String(describing: self)
    }

    static var Nib: UINib {
        return UINib(nibName: NibName, bundle: nil)
    }
}
