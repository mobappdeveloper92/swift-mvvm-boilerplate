//
//  VerifyOTPRequest.swift
//  Jood
//
//  Created by Faizan Mahmood on 21/09/2022.
//

import Foundation

struct VerifyOTPRequest: Codable {
    var otp: String = "112244"
    var phoneCode: String = ""
    var phoneNumber: String = ""
    var email: String?

    init(email: String?) {
        self.email = email
    }
}
