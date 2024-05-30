//
//  Created by Faizan Mahmood on 25/05/2022.
//

protocol CountrySelectionViewControllerDelegate: NSObjectProtocol {
    func didSelectCountry(from: CountrySelectionViewController, country: Country, type: CountrySelectionType)
}

import UIKit
import SwiftUI

class CountrySelectionViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var navBarLine: BaseView!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var tblView: UITableView!
    
    weak var delegate: CountrySelectionViewControllerDelegate?
    var type: CountrySelectionType = .code
    
    lazy var viewModel: CountrySelectionViewModel = {
        return CountrySelectionViewModel(type: self.type)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareDelegates()
    }
}

// MARK: - Actions
extension CountrySelectionViewController {
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - View Related
extension CountrySelectionViewController {
    func prepareView() {
        navBarLine.addShadow(shadowOpacity: 0.35,
                                     shadowColor: .black,
                                     shadowRadius: 2,
                                     shadowOffset: .init(width: 0, height: 1))
        prepareTableView()
        prepareSearchBar()
        setTranslations()
    }

    func setTranslations() {
        lblTitle.text = "Select Country"
    }
}

// MARK: - Helper Functions
extension CountrySelectionViewController {
    private func prepareTableView() {
        tblView.contentInset = .init(top: 40, left: 0, bottom: 0, right: 0)
        registerCells()
        // setFooterView()
    }
    
    private func prepareDelegates() {
        viewModel.delegate = self
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    private func prepareSearchBar() {
        searchView.delegate = self
        searchView.setPlaceholder("Search here")
    }
    
    private func registerCells() {
        tblView.register(CountrySelectionTableViewCell.nib,
                         forCellReuseIdentifier: CountrySelectionTableViewCell.id)
    }
    
    private func setFooterView() {
        let view = UIView.init()
//        view.backgroundColor = UIColor.getColor(.cardBackground)
        self.tblView.tableFooterView = view
    }
}

// MARK: - Tableview Datasource
extension CountrySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.isSearchMode ? 1 : viewModel.sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearchMode ? viewModel.searchResults.count :
        (viewModel.getCountries()[viewModel.sectionsTitles[section]]?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(
            withIdentifier: CountrySelectionTableViewCell.id, for: indexPath
        ) as? CountrySelectionTableViewCell else {
            return UITableViewCell()
        }
        let country = viewModel.isSearchMode ?
        viewModel.searchResults[indexPath.row]
        : viewModel.getCountries()[viewModel.sectionsTitles[indexPath.section]]?[indexPath.row]
        cell.bindData(data: country, type: type)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0 //viewModel.isSearchMode ? 1.0 : 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !viewModel.isSearchMode else {
            return nil
        }
        guard let title = viewModel.isSearchMode ? nil : viewModel.sectionsTitles[section] else {
            return nil
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.getFont(.medium, size: 20)
            header.textLabel?.textColor = .getColor(.primary)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isSearchMode {
            let data = viewModel.searchResults[indexPath.row]
            delegate?.didSelectCountry(from: self, country: data, type: type)
            self.dismiss(animated: true)
            return
        }
        guard let data = viewModel.getCountries()[viewModel.sectionsTitles[indexPath.section]]?[indexPath.row] else {
            return
        }
        delegate?.didSelectCountry(from: self, country: data, type: type)
        self.dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension CountrySelectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CountrySelectionViewController: SearchViewDelegate {
    func didChangeInText(from searchView: SearchView, text: String) {
        viewModel.search(text: text)
    }

    func didTapSearchButton(from searchView: SearchView, text: String?) {
        view.endEditing(true)
    }
}

// MARK: - ViewModelDelegate
extension CountrySelectionViewController: CountrySelectionViewModelDelegate {
    func reloadTableView(from: CountrySelectionViewModel) {
        tblView.reloadData()
    }
}

enum CountrySelectionType {
    case country
    case code
}
