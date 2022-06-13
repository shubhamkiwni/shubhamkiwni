//
//  StringValidationExtension.swift
//  Kiwni
//
//  Created by Shubham Shinde on 18/04/22.
//

import Foundation

enum AllowedCharacters {
    case numbers
    case alphabets
    case alphaNumeric
}

enum Mask: String {
    case withCountryCode = "XXX XXX XXXX"
    case withoutCountryCode = "(XXX) XXX-XXXX"
    case withoutSpace = "XXXXXXXXXX"
}

extension Date {
    func getTimestamp() -> String {
        let timeInterval = self.timeIntervalSince1970 * 1000000
        return String(format: "%.0f", timeInterval)
    }
}

extension String {
    var onlyNumbers: String? {
        filter {Int("\($0)") != nil}
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
//        e.g.: [0..<5]
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        
        return String(self[start..<end])
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
//        e.g.: [0...5]
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }

        return String(self[start...end])
    }

    subscript (bounds: CountablePartialRangeFrom<Int>) -> String {
//        e.g.: [5...]
        let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
        let end = self.index(self.endIndex, offsetBy: -1)
        if end < start { return "" }

        return String(self[start...end])
    }

    subscript (bounds: PartialRangeThrough<Int>) -> String {
//        e.g.: [...5]
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        if end < self.startIndex { return "" }

        return String(self[self.startIndex...end])
    }

    subscript (bounds: PartialRangeUpTo<Int>) -> String {
//        e.g.: [5..<]
        let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
        if end < self.startIndex { return "" }

        return String(self[self.startIndex..<end])
    }
    
    var isNumber: Bool {
        return self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var isAlphabets: Bool {
        return self.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil
    }
    
    var isAlphanumeric: Bool {
        return self.rangeOfCharacter(from: CharacterSet.letters.union(CharacterSet.decimalDigits).inverted) == nil
    }

    var isPhoneNumber: Bool {
        let regExpr = "^(\\+\\d{1,2})?\\(?\\d{3}\\)?\\d{3}\\d{4}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpr)

        return predicate.evaluate(with: self)
    }
    
    var isEmail: Bool {
        let regExpr = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExpr)
    
        return predicate.evaluate(with: self)
    }
    
    var isURL: Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: self)
    }
    
    mutating func separate(uaing separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
        
    private func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0+n, count)])
            
            if $0+n < count {
                result += separator
            }
        }
        
        return result
    }
        
    static func random(withLength length: Int, allowedCharacters: AllowedCharacters) -> String {
        var letters = ""
        
        switch allowedCharacters {
            case .numbers:
                letters = "0123456789"

            case .alphabets:
                letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

            case .alphaNumeric:
                letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        }
        
        let randomString : NSMutableString = NSMutableString(capacity: length)
        
        for _ in 0...length {
            let randomNum = Int(arc4random_uniform(UInt32(letters.count)))
            let randomIndex = letters.index(letters.startIndex, offsetBy: randomNum)
            let newCharacter = letters[randomIndex]
            
            randomString.append(String(newCharacter))
        }
        
        return randomString as String
    }
    
    //Mask phone number
    func mask(withFormat mask: Mask) -> String? {
        var formattedNumbers = ""
        
        if self.count < 10 {
            return nil
        }
        
        var numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if mask == .withoutCountryCode || mask == .withoutSpace {
            numbers = String(numbers.suffix(10))
        }
        
        if mask.rawValue.hasPrefix("+XX") {
            formattedNumbers = String(repeating: "~~", count: 12)
            formattedNumbers = (formattedNumbers + numbers)
            formattedNumbers = String(formattedNumbers.suffix(12))
            
            // Default to US country code
            formattedNumbers = formattedNumbers.replacingOccurrences(of: "~~", with: "01")
            formattedNumbers = formattedNumbers.replacingOccurrences(of: "~", with: "0")
        } else {
            formattedNumbers = numbers
        }
        
        var result = ""
        var index = formattedNumbers.startIndex

        for ch in mask.rawValue where index < formattedNumbers.endIndex {
            if ch == "X" {
                result.append(formattedNumbers[index])
                
                index = formattedNumbers.index(after: index)

            } else {
                result.append(ch)
            }
        }

        return result
    }
    
    func suffixTimestamp() -> String {
        let uniqueTime = Date().getTimestamp()
        
        return "\(self)\(uniqueTime)"
    }
    
    func plural() -> String
    {
        let vowels = ["a", "e", "i", "o", "u"]
        let consonants = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]

        let lastAlphabet = self[self.count - 1]
        let last2ndAlphabet = self[self.count - 2]

        var prefix = ""
        var suffix = ""

        if lastAlphabet.lowercased() == "y" && vowels.filter({x in x == last2ndAlphabet}).count == 0 {
            let start = self.index(self.startIndex, offsetBy: 0)
            let end = self.index(self.endIndex, offsetBy: -2)

            prefix = String(self[start...end])
            suffix = "ies"
        } else if lastAlphabet.lowercased() == "s" || (lastAlphabet.lowercased() == "o" && consonants.filter({x in x == last2ndAlphabet}).count > 0) {
            let start = self.index(self.startIndex, offsetBy: 0)
            let end = self.index(self.endIndex, offsetBy: -1)

            prefix = String(self[start...end])
            suffix = "es"
        } else {
            let start = self.index(self.startIndex, offsetBy: 0)
            let end = self.index(self.endIndex, offsetBy: -1)

            prefix = String(self[start...end])
            suffix = "s"
        }

        return prefix + (lastAlphabet != lastAlphabet.uppercased() ? suffix : suffix.uppercased())
    }
    
    func truncate(to length: Int, addEllipsis: Bool = true) -> String  {
        if length > count { return self }

        let end = self.index(self.startIndex, offsetBy: length)
        let trimmed = self[..<end]

        if addEllipsis {
            return "\(trimmed)..."
        } else {
            return "\(trimmed)"
        }
    }
    
    func padLeft(upTo length: Int, using element: Element = " ") -> SubSequence {
        return repeatElement(element, count: Swift.max(0, length - self.count)) + suffix(Swift.max(self.count, self.count - length))
    }
    
    
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
  
}
