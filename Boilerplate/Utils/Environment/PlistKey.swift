//
//  PlistKey.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 25/04/2022.
//

import Foundation

enum PlistKey: String {
    case baseURL = "Base URL"

    private var infoDictionary: [String: Any] {
        if let dictionary = Bundle.main.infoDictionary {
            return dictionary
        } else {
            fatalError("Relevant .plist file not found")
        }
    }

    func value() -> String {
        guard let value = infoDictionary[self.rawValue] as? String else {
            return ""
        }
        return value
    }
}
