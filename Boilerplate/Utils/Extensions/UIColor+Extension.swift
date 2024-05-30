//
//  Created by Faizan Mahmood
//

import Foundation
import UIKit

extension UIColor {

    static func getColor(_ color: AssetColor) -> UIColor {
        return UIColor(named: color.rawValue) ?? UIColor.clear
    }

    enum AssetColor: String {
        case border
        case cellHeading
        case cellSubHeading
        case darkGrey
        case lightGrey
        case placeholder
        case primary
        case secondary
        case separator
        case pageDot
        case unselectedTab
    }
}
