//
//  CoreDataController.swift
//  e-learning
//
//  Created by rvaidya on 24/11/21.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    var container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "e_learning")
        container.loadPersistentStores { description, error in

            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
