//
//  Created by Faizan Mahmood on 25/05/2022.
//
protocol CountrySelectionViewModelDelegate: NSObjectProtocol {
    func reloadTableView(from: CountrySelectionViewModel)
}

import Foundation
import ObjectiveC

class CountrySelectionViewModel {
    fileprivate var data: [Country] = []
    var isSearchMode: Bool = false
    var sectionsTitles = [String]()
    var searchResults: [Country] = []
    var type: CountrySelectionType = .code
    fileprivate var countries = [String: [Country]]()
    weak var delegate: CountrySelectionViewModelDelegate?
    
    init(type: CountrySelectionType) {
        self.type = type
        setData()
    }
    
    func getData() -> [Country] {
        return data
    }
    
    func getCountries() -> [String: [Country]] {
        return countries
    }
    
    func search(text: String) {
        searchText(text: text)
    }
}

// MARK: - Helper FUnctions
private extension CountrySelectionViewModel {
    func setData() {
        data = type == .code ? CountryHelper.shared.getCountriesForPhone() : CountryHelper.shared.getCountries() ?? []
        prepareData()
    }
    
    func prepareData() {
        let countriesArray = data
        // swiftlint:disable syntactic_sugar
        var groupedData = Dictionary<String, [Country]>(grouping: countriesArray) {
            let name = $0.name ?? ""
            return String(name.capitalized[name.startIndex])
        }
        groupedData.forEach { key, value in
            groupedData[key] = value.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.name ?? "" < rhs.name ?? ""
            })
        }
        
        countries = groupedData
        sectionsTitles = groupedData.keys.sorted()
    }
    
    func searchText(text: String) {
        isSearchMode = false
        if !text.isEmptyOrWhitespace() {
            isSearchMode = true
            searchResults.removeAll()
            
            let indexArray = getData()
            
            searchResults.append(contentsOf: indexArray.filter({
                let name = $0.name?.lowercased()
                let query = text.lowercased()
                return name?.hasPrefix(query) ?? false
            }))
        }
        delegate?.reloadTableView(from: self)
    }
}
