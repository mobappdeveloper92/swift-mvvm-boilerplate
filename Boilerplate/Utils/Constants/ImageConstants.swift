//
//  ImageConstants.swift
//  Jood
//
//  Created by Faizan Mahmood on 20/09/2022.
//

import Foundation
import UIKit

enum ImageConstants: String {
    case testImage = "test_image"

    func getImage() -> UIImage? {
        return .init(named: self.rawValue)
    }
}
