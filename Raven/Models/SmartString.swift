//
//  SmartString.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation

class SmartString {
    
    var value: String
    var isPunctuation: Bool
    
    init(value: String, isPunctuation: Bool) {
        self.value = value
        self.isPunctuation = isPunctuation
    }
}
