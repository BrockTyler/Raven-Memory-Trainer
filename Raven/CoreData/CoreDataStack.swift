//
//  CoreDataStack.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RavenCoreData")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
