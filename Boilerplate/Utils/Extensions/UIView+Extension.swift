//
//  Created by Faizan Mahmood
//

import Foundation
import UIKit

extension UIView {

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let currentTx: CGFloat = self.transform.tx
        animation.duration = 0.5
        animation.values = [
            NSNumber(value: Float(currentTx)),
            NSNumber(value: Float(currentTx + 10)),
            NSNumber(value: Float(currentTx - 8)),
            NSNumber(value: Float(currentTx + 8)),
            NSNumber(value: Float(currentTx - 5)),
            NSNumber(value: Float(currentTx + 5)),
            NSNumber(value: Float(currentTx))
        ]
        animation.keyTimes = [
            NSNumber(value: 0),
            NSNumber(value: 0.225),
            NSNumber(value: 0.425),
            NSNumber(value: 0.6),
            NSNumber(value: 0.75),
            NSNumber(value: 0.875),
            NSNumber(value: 1)
        ]
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.layer.add(animation, forKey: "kAFViewShakerAnimationKey")
    }

    func addShadow(shadowOpacity: Float = 0.1,
                   shadowColor: UIColor = .black,
                   shadowRadius: CGFloat = 5,
                   shadowOffset: CGSize = .init(width: 0, height: 3)) {
        layer.masksToBounds = false
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
    }

    func setBorder(borderColor: UIColor = .clear, borderWidth: CGFloat = 1, cornerRadius: CGFloat = 10) {
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

