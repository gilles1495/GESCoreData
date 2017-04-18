//
//  CoreDataManager.swift
//  GESCoreData
//
//  Created by gilles Goncalves on 18/04/2017.
//  Copyright © 2017 gilles et julien. All rights reserved.
//

import CoreData

class CoreDataManager: NSObject {

    public static let shared = CoreDataManager()
    
    public var context: NSManagedObjectContext?
    
    private override init() {
        guard let schema = Bundle.main.url(forResource: "SimpleCoreData", withExtension: "momd") else{
            return
        }
        guard let model = NSManagedObjectModel(contentsOf : schema)else{
            return
        }
        
        let store = NSPersistentStoreCoordinator(managedObjectModel: model)
        print(FileUtils.getDocumentFile(at: "simple.sqlite").path)
        do{
            try store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: FileUtils.getDocumentFile(at: "simple.sqlite"), options: nil)
        } catch {
            print(error)
            return
        }
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        context.persistentStoreCoordinator = store
        self.context = context
    }
}
