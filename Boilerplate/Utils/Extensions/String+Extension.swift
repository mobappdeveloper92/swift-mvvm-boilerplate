//
//  Created by Faizan Mahmood
//

import Foundation

extension String {

    var isBlank: Bool {
        let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
        return trimmed.isEmpty
    }

    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: .init(location: 0, length: self.count)) != nil
        } catch {
            return false
        }
    }

    var isValidPassword: Bool {
        return self.count >= 8
    }

}

extension String {

    mutating func lowerCase() {
        self = self.lowercased()
    }

    mutating func upperCase() {
        self = self.uppercased()
    }

    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string,
                                         with: replacement,
                                         options: NSString.CompareOptions.literal,
                                         range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }

    func isEmptyOrWhitespace() -> Bool {
        if self.isEmpty {
            return true
        }
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces) == ""
    }
}

extension String {
    func date(withFormat formatter: DateFormatter = .yyyyMMddHHmmss) -> Date? {
        formatter.locale = .init(identifier: LanguageManager.shared.currentLanguage.rawValue)
        return Date(string: self, formatter: formatter)
    }
}

extension String {
    func getHTMLAttributedString() -> NSAttributedString? {
        guard let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue) else {
            return nil
        }
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
        do {
            let attributedString = try NSMutableAttributedString(data: htmlData,
                                                                      options: options,
                                                                      documentAttributes: nil)
            return attributedString
        } catch let error {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
}

extension String {
    func toDictionary() -> [String: String]? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension StringProtocol {
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
    var removingAllExtraNewLines: String { lines.joined(separator: "\n") }
}
