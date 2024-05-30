//
//  Environment.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 25/04/2022.
//

import Foundation

struct Environment {

    static let shared = Environment()

    private init() {}

    private var infoDictionary: [String: Any] {
        get {
            if let dictionary = Bundle.main.infoDictionary {
                return dictionary
            } else {
                fatalError("Relevant .plist file not found")
            }
        }
    }

    func getValue<T>(for key: PlistKey) -> T {
        return infoDictionary[key.rawValue] as! T
    }

    static subscript<T>(key: PlistKey) -> T {
        if let dictionary = Bundle.main.infoDictionary {
            return dictionary[key.rawValue] as! T
        } else {
            fatalError("Relevant .plist file not found")
        }
    }


}
