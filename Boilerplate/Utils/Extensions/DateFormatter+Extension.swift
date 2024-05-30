//
//  Created by Faizan Mahmood
//

import Foundation

extension DateFormatter {
    static let yyyyMMddHHmmss: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue
        return dateFormatter
    }()

    static let hhmmaSepddMMMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.hhmmaSepddMMMMyyyy.rawValue
        return dateFormatter
    }()

    static let ddMMMMyyyySephhmma: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.ddMMMMyyyySephhmma.rawValue
        return dateFormatter
    }()

    static let ddMMMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.ddMMMMyyyy.rawValue
        return dateFormatter
    }()

    static let ddMMMMyyyyWithoutSep: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.ddMMMMyyyyWithoutSep.rawValue
        return dateFormatter
    }()

    static let ddMMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.ddMMMyyyy.rawValue
        return dateFormatter
    }()

    static let yyyyMMdd: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        return dateFormatter
    }()

    static let HHmm: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.HHmm.rawValue
        return dateFormatter
    }()
}
