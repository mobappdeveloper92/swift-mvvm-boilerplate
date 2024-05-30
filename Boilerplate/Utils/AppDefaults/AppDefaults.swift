//
//  AppDefaults.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import CoreLocation

class AppDefaults: UserDefaults {

    static var shared = AppDefaults()

    override class var standard: UserDefaults {
        return UserDefaults.standard
    }

    static func clearUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }

    static var isLogin: Bool {
        get{ AppDefaults[#function] ?? false }
        set{ AppDefaults[#function] = newValue }
    }

    static var token: String? {
        get{ AppDefaults[#function] }
        set{ AppDefaults[#function] = newValue }
    }

    static var user: User? {
        get{ AppDefaults[#function] }
        set{ AppDefaults[#function] = newValue }
    }
}


extension AppDefaults {

    static subscript<T: Codable>(key: String) -> T? {
        get { AppDefaults.shared.getValue(key) }
        set(newValue) { AppDefaults.shared.setValue(newValue, for: key) }
    }

    fileprivate func getValue<T: Codable>(_ key: String) -> T? {
        guard let data = AppDefaults.standard.data(forKey: key) else { return nil }
        return decode(data).0
    }

    fileprivate func setValue<T: Codable>(_ value: T, for key: String) {
        let decoded = encode(value)
        if let data = decoded.data {
            AppDefaults.standard.set(data, forKey: key)
            AppDefaults.standard.synchronize()
        }else{
            print("Value not set for \(key): \(decoded.error?.localizedDescription ?? "")")
        }
    }

}
