//
//  APIHeader.swift
//  TestCasesDemo
//
//  Created by Faizan Mahmood on 11/09/2023.
//

import Foundation
import UIKit

class APIHeader {

    static let shared = APIHeader()

    private init() { }

    func getHeader() -> [String: String] {
        return [
            "Accept-Language": LanguageManager.shared.currentLanguage.rawValue,
            "Content-Type": "application/json",
            "deviceid": "382E7F6D-E2FA-4283-A3F2-1DF8FDF33955",
            "platform": "ios"
        ]
    }

    func getHeaderWithToken() -> [String: String] {
        return [
            "Accept-Language": LanguageManager.shared.currentLanguage.rawValue,
            "Content-Type": "application/json",
            "deviceid": "382E7F6D-E2FA-4283-A3F2-1DF8FDF33955",
            "platform": "ios",
            "Authorization": "Bearer \(AppDefaults.token ?? "")"
        ]
    }

}
