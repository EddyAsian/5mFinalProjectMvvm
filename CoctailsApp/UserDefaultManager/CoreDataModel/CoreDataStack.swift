//
//  CoreDataStack.swift
//  CoctailsApp
//
//  Created by Eldar on 24/2/23.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storageContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error is: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = storageContainer.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch {
            print("Error is: \(error.localizedDescription)")
        }
    }
}
