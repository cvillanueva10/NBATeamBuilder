//
//  CreateTeamController+HandleSaveEdit.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

extension CreateTeamController {
    
    // Dismiss current controller and add team
    // to TeamsController tableView and save to Core Data
    @objc func handleSave() {
        if team == nil {
            createTeam()
        } else {
            saveTeamChanges()
        }
    }
    
    func createTeam(){
        // initialization of Core Data stack
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: context)
        team.setValue(nameTextField.text, forKey: "name")
        team.setValue(foundedYearString, forKey: "founded")
        
        if let teamImage = teamImageView.image {
            let imageData = UIImageJPEGRepresentation(teamImage, 0.8)
            team.setValue(imageData, forKey: "imageData")
        }
        
        // Save team object
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddTeam(team: team as! Team)
            })
        } catch let saveError {
            print("Failed to save team:", saveError)
        }
    }
    
    func saveTeamChanges(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        team?.name = nameTextField.text
        team?.founded = foundedYearString
        
        if let teamImage = teamImageView.image {
            let imageData = UIImageJPEGRepresentation(teamImage, 0.8)
            team?.imageData = imageData
        }
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditTeam(team: self.team!)
            })
        } catch let saveError {
            print("Error updating team: ", saveError)
        }
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
}
