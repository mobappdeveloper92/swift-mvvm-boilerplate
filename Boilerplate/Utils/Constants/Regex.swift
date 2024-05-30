//
//  Regex.swift
//  Jood
//
//  Created by Faizan Mahmood on 16/09/2022.
//

import Foundation

struct Regex {
    static let numbers = "+0123456789"
    static let alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let alphaSpecial = "[a-zA-Z ()'’-]+"
    static let alphaNumerics = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    static let url = "(?:http|https)://(?:www\\.)?\\S+(?:/|\\b)"
    static let password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}+"

    static func getEmailRegex() -> String {
        return Regex.email
    }

    static func getPasswordRegex() -> String {
        return Regex.password
    }
}
