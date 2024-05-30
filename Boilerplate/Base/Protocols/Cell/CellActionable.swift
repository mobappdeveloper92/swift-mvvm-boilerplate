//
//  CellActionable.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 20/04/2022.
//

import Foundation

enum CellAction {
    case select(_ indexPath: IndexPath)
    case update(_ indexPath: IndexPath)
    case delete(_ indexPath: IndexPath)
}

typealias CellCallBack = (CellAction) -> Void

protocol CellActionable: AnyObject {
    var cellCallBack: CellCallBack? { get set }
}
