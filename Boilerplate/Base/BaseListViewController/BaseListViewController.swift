//
//  BaseListViewController.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 22/04/2022.
//

import Foundation
import UIKit

class BaseListViewController<ModelType: Codable, CellType: TableViewCell & CellActionable> : BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    var data: [ModelType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }

    func prepareTableView() {
        tblView.register(CellType.Nib, forCellReuseIdentifier: CellType.reuseIdentifier)
    }

    func setData(data: [ModelType]) {
        self.data = data
        tblView.reloadData()
        showEmptyDataView(self.data.isEmpty, for: .general)
    }

    func showEmptyDataView(_ isShow: Bool, for type: EmptyDataType) {
        tblView.showEmptyDataView(isShow, for: type)
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }

    /// Use this for overriding didSelectRowAt of tableview
    func didSelectRow(at indexPath: IndexPath) {
        print("\(#function) is not overrided")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath) as? CellType
        guard let cell = tableCell else {
            return UITableViewCell()
        }
        cell.cellCallBack = { action in
            self.onAction(action: action)
        }
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }

    /// Can be override for customization
    func configureCell(cell: CellType, indexPath: IndexPath) {
        guard let modelType = data[indexPath.row] as? CellType.ModelType else {
            return
        }
        cell.configureWithModel(modelType, indexpath: indexPath)
    }

    /// Can be override for customization
    func onAction(action: CellAction) {
        print("\(#function) is not overrided")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

