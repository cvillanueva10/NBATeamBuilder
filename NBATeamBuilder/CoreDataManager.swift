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
    
    func fetchTeams() -> [Team] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        do {
            let teams = try context.fetch(fetchRequest)
            return teams
        } catch let fetchError {
            print("Failed to fetch teams: ", fetchError)
            return []
        }
    }
    
    func createPlayer(playerName: String) -> Error? {
        let context = persistentContainer.viewContext
        
        //create player
        let player = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context)
        player.setValue(playerName, forKey: "name")
        
        do {
            try context.save()
            return nil
        } catch let saveError {
            print("Error saving player: ", saveError)
            return saveError
        }
        
        
    }
}



