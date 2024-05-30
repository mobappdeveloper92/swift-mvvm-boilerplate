//
//  CountryHelper.swift
//  Jood
//
//  Created by Faizan Mahmood on 16/09/2022.
//

import Foundation

class CountryHelper {

    static let shared = CountryHelper()

    private var countries: [Country]?

    private init() {
        countries = getData(from: "Nationalities")
    }

    func getCountries() -> [Country]? {
        return countries
    }

    func getCountryByName(name: String) -> Country? {
        guard let country = getCountries()?.filter({
            $0.name?.lowercased() == name.lowercased()
        }).first else {
            return nil
        }
        return country
    }

    func getCountryByCode(code: String) -> Country? {
        guard let country = getCountries()?.filter({
            $0.code == code
        }).first else {
            return nil
        }
        return country
    }

    func getCountryById(id: String) -> Country? {
        guard let country = getCountries()?.filter({
            $0.id.lowercased() == id.lowercased()
        }).first else {
            return nil
        }
        return country
    }

    func getCountriesForPhone() -> [Country] {
        return countries ?? []
    }
}
