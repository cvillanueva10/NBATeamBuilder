//
//  CoreDataManager.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 12/30/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    // this variable will live forever as long as the application is alive
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TeamModels")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading failed: \(error)")
            }
        }
        return container
    }() 
    
}
