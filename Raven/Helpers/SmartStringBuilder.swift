//
//  SmartStringBuilder.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation

extension String {
    
    func buildSmartStringArray() -> [SmartString] {
        let words = self.components(separatedBy: " ")
        var smartStrings: [SmartString] = []
        for word in words {
            guard let lastCharacter = word.last,
                let scalar = Unicode.Scalar(String(lastCharacter)) else { continue }
            if CharacterSet.punctuationCharacters.contains(scalar) {
                var cleanWord = word
                let punctuationCharacter = cleanWord.removeLast()
                smartStrings.append(SmartString(value: cleanWord, isPunctuation: false))
                smartStrings.append(SmartString(value: String(punctuationCharacter), isPunctuation: true))
            } else {
                smartStrings.append(SmartString(value: word, isPunctuation: false))
            }
        }
        return smartStrings
    }
}
