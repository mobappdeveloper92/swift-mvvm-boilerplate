//
//  Validator.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation

enum ValidatorType {
    case name
    case email
    case password
    case requiredField(field: String)
}

enum ValidationConstants {
    static let minName = 3
    static let maxName = 32
    static let minPassword = 8
    static let maxPassword = 30
    static let minEmail = 6
    static let maxEmail = 30
    static let minPhone = 8
    static let maxPhone = 13
}

class ValidationError: Error {
    var message: String

    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .name: return NameValidator()
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        }
    }
}

struct NameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= ValidationConstants.minName else {
            throw ValidationError("Name must contain more than \(ValidationConstants.minName) characters" )
        }
        guard value.count < ValidationConstants.maxName else {
            throw ValidationError("Username shoudn't conain more than \(ValidationConstants.maxName) characters" )
        }

        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,\(ValidationConstants.maxName)}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {throw ValidationError("Email is required")}
        do {
            if try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid email address")
            }
        } catch {
            throw ValidationError("Invalid email address")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {throw ValidationError("Password is required")}
        guard value.count >= ValidationConstants.minPassword else { throw ValidationError("Password must have at least \(ValidationConstants.minPassword) characters") }

        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String

    init(_ field: String) {
        fieldName = field
    }

    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError(fieldName + " is required")
        }
        return value
    }
}
