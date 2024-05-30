//
//  UIComponent+Alignment.swift
//  Ecommerce
//
//  Created by Faizan Mahmood on 25/11/2022.
//

import Foundation
import UIKit

extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if textAlignment == .natural {
            self.textAlignment = LanguageManager.shared.isRightToLeft ? .right : .left
        }
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if textAlignment == .natural {
            self.textAlignment = LanguageManager.shared.isRightToLeft ? .right : .left
        }
    }
}

extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if textAlignment == .natural {
            self.textAlignment = LanguageManager.shared.isRightToLeft ? .right : .left
        }
    }
}

extension UISwitch {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.semanticContentAttribute = LanguageManager.shared.isRightToLeft ?
            .forceRightToLeft : .forceLeftToRight
    }
}

extension UIPageControl {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.transform = LanguageManager.shared.isRightToLeft ?
        CGAffineTransformMakeScale(-1, 1) : .identity
    }
}
