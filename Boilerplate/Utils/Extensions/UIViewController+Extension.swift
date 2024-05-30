//
//  Created by Faizan Mahmood
//

import Foundation
import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    weak var authNavigator: AuthNavigator? {
        return AuthNavigator.init(navigationController: self.navigationController)
    }
}
