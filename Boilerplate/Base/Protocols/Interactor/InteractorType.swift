//
//  InteractorType.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 14/09/2023.
//

import Foundation
import Moya

protocol InteractorType {
    associatedtype APIType: TargetType
    var networkManager: NetworkManager<APIType>? {get set}
}
