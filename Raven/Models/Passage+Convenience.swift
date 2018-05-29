//
//  Passage+Convenience.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation
import CoreData


extension Passage {
    
    static let aaa = CFTimeZoneCopySystem()
    
    @discardableResult convenience init(title: String, text: String, creationDate: Date = Date(), practiceDate: Date =
        Date(timeIntervalSince1970: 0), wasPracticed: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.title = title
        self.text = text
        self.practiceDate = practiceDate
        self.creationDate = creationDate
    }
    
}
