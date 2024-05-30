//
//  Country.swift
//  Jood
//
//  Created by Faizan Mahmood on 02/06/2022.
//

import Foundation
import UIKit

struct Country: Codable {
    var id: String = "SA"
    var name: String?
    var code: String?

    public var flag: UIImage? {
        return FlagNames().getImage(with: id)
    }

    func getCode() -> String {
        return code ?? "+966"
    }
}
