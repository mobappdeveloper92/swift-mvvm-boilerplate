//
//  Created by Faizan Mahmood
//

import Foundation

extension RelativeDateTimeFormatter {
    static let relativeDateTimeFormatter: RelativeDateTimeFormatter = {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.unitsStyle = .full
        return dateFormatter
    }()
}
