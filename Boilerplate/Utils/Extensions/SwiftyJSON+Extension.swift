//
//  Created by Faizan Mahmood
//

import Foundation
import SwiftyJSON

extension JSON {
    var isSuccess: Bool {
        self["success"].boolValue
    }

    var message: String {
        self["message"].stringValue
    }

    var dataRef: JSON {
        self["data"]
    }

    var token: String {
        self["data"]["token"].stringValue
    }

    var userRef: JSON {
        self["data"]["user"]
    }
}

extension JSON {
    func printResponse(_ function: String) -> JSON {
        #if DEBUG
        print("\(function) response:")
        debugPrint("=========================================================")
        debugPrint(self)
        debugPrint("=========================================================")
        #endif
        return self
    }
}

extension Data {
    func toJSON(_ function: String) -> JSON {
        return JSON(self).printResponse(function)
    }
}

