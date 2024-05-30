//
//  Created by Faizan Mahmood
//

import Foundation
import UIKit

public extension UIFont {
    enum Effra: String {
        case light = "Effra Light"
        case regular = "Effra"
        case medium = "Effra Medium"
        case bold = "Effra Bold"
        case italic = "Effra Italic"
    }

    static func getFont(_ type: Effra = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

extension UIFont {

    func autoDimentionFont() -> UIFont {
        // This can be change according to design (Here we are considering design in Iphone 13 Pro Max)
        let designHeight: CGFloat =  926.0
        let dimentedSize: CGFloat = ((UIDevice.screenHeight * pointSize) / designHeight).rounded(.up)
        return (UIFont(name: fontName, size: dimentedSize) ?? UIFont.systemFont(ofSize: dimentedSize))
    }
    
}
