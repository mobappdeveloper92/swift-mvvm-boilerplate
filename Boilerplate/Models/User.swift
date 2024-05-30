//
//  User.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation
import UIKit

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let phoneCode: String?
    let phoneNumber: String?
    let accessToken: String?
    let refreshToken: String?
    let dateOfBirth: Int64?
    let nationality: String?
    let pointBalance: Int?
    let totalPointsEarned: Int?
    let totalPointsRedeemed: Int?
    let profileImage: String?
    let isVerified: Bool?
    let isSubscribed: Bool?
    var userLocale: String?

    mutating func updateLocale(to locale: String?) {
        userLocale = locale
    }

    func getDateOfBirth() -> String? {
        if let dateOfBirth = dateOfBirth, dateOfBirth != 0 {
            let date = Date.init(milliseconds: dateOfBirth)
            return date.string(with: .ddMMMMyyyy)
        } else {
            return nil
        }
    }

    func getBirthDate() -> Date? {
        if let dateOfBirth = dateOfBirth, dateOfBirth != 0 {
            return Date.init(milliseconds: dateOfBirth)
        } else {
            return nil
        }
    }

    func getNationality() -> String? {
        guard let id = nationality else { return nil }
        return CountryHelper.shared.getCountryById(id: id)?.name
    }

    func getPoints() -> Int {
        return pointBalance ?? 0
    }
}
