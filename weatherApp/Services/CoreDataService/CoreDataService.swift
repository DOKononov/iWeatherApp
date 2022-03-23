//
//  CoreDataService.swift
//  weatherApp
//
//  Created by Dmitry Kononov on 22.03.22.
//

import Foundation
import CoreData

final class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}

     var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
   private var persistentContainer: NSPersistentCloudKitContainer = {

        let container = NSPersistentCloudKitContainer(name: "weatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

