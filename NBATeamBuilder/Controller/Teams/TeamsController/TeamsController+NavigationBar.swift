//
//  TeamsController+NavigationBar.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

extension TeamsController {
    
    // Present controller for creating a new team
    // and link it to this controller instance
    @objc func handleAddTeam() {
        let createTeamController = CreateTeamController()
        createTeamController.delegate = self
        let navigationController = CustomNavigationController(rootViewController: createTeamController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func handleNestedUpdates() {
        
        DispatchQueue.global(qos: .background).async {
            
            //custom MOC
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            
            let request: NSFetchRequest<Team> = Team.fetchRequest()
            request.fetchLimit = 1
            
            do {
                let teams = try privateContext.fetch(request)
                teams.forEach({ (team) in
                    print(team.name ?? "")
                    team.name = "San Francisco Warriors"
                })
                
                do {
                    try privateContext.save()
                    DispatchQueue.main.async {
                        
                        do {
                            let context = CoreDataManager.shared.persistentContainer.viewContext
                            if context.hasChanges {
                                try context.save()
                            }
                        } catch let finalSaveError {
                            print("Failed to save on main context: ", finalSaveError)
                        }
                        self.tableView.reloadData()
                    }
                } catch let saveError {
                    print("Failed to save on private context: ", saveError)
                }
            } catch let fetchErr {
                print("Failed to fetch: ", fetchErr)
            }
            
        }
    }
    
    // Delete all teams
    @objc func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Team.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in teams.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            teams.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
        } catch let deleteError {
            print("Failed to delete objects from Core Data: ", deleteError)
        }
    }
}
