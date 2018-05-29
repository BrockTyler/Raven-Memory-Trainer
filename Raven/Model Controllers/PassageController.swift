//
//  PassageController.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import Foundation
import CoreData


class PassageController {
        
    // MARK: - CRUD Methods
    
    static func addPassage(title: String, text: String) {
        
        let _ = Passage(title: title, text: text)
        saveToPersistentStorage()
    }
    
    static func editPassage(passage: Passage, title: String, text: String) {
        
        passage.title = title
        passage.text = text
        saveToPersistentStorage()
    }
    
    static func deletePassage(passage: Passage) {
        passage.managedObjectContext?.delete(passage)
        saveToPersistentStorage()
    }
    
    static func createSamplePassage(title: String, text: String) {
        guard UserDefaults.standard.bool(forKey: "didCreateSamplePassage") == false else { return }
        let _ = Passage(title: title, text: text)
        saveToPersistentStorage()
        UserDefaults.standard.set(true, forKey: "didCreateSamplePassage")
    }
    
    static func updatePracticeDate(passage: Passage) {
        passage.practiceDate = Date()
        saveToPersistentStorage()
    }
    
    static func updateWasPracticed(passage: Passage, updatedStatus: Bool) {
        passage.wasPracticed = updatedStatus
        saveToPersistentStorage()
    }
    
    // MARK: - Private Methods
    
    private static func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Error while saving managed object context - items not saved: \(error.localizedDescription)")
        }
    }
}
