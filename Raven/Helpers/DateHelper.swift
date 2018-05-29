//
//  DateHelper.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter
    }()
}
