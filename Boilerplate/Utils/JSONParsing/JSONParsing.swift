//
//  JSONParsing.swift
//  Boilerplate
//
//  Created by Faizan Mahmood on 19/04/2022.
//

import Foundation
import SwiftyJSON

func decode<T: Decodable>(_ data: Data) -> (decodedType: T?, error: Error?) {
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        return (decoded, nil)
    } catch {
        debugPrint(error)
        return (nil, error)
    }
}

func decode<T: Decodable>(_ json: JSON) -> (decodedType: T?, error: Error?) {
    do {
        let data = try json.rawData()
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        return (decoded, nil)
    } catch {
        debugPrint(error)
        return (nil, error)
    }
}

func encode<T: Encodable>(_ value: T) -> (data: Data?, error: Error?) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(value)
        return (data, nil)
    } catch {
        debugPrint(error)
        return (nil, error)
    }
}

func getData<T: Decodable>(from file: String) -> T? {
    guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else {
        fatalError("\(file).json not found!")
    }
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        print("\(file).json data: \n\(decoded)")
        return decoded
    } catch {
        debugPrint(error)
        return nil
    }
}

func getFileData(from file: String) -> Data? {
    guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else {
        fatalError("\(file).json not found!")
    }
    do {
        let data = try Data(contentsOf: fileURL)
        return data
    } catch {
        debugPrint(error)
        return nil
    }
}
