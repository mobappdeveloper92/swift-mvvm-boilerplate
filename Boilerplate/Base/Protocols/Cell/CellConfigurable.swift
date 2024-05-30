//
//  CellConfigurable.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 20/04/2022.
//

import Foundation

protocol CellConfigurable {

    associatedtype ModelType

    var model: ModelType? { get set }
    var indexpath: IndexPath? { get set }

    func configureWithModel(_ model: ModelType, indexpath: IndexPath)
}
