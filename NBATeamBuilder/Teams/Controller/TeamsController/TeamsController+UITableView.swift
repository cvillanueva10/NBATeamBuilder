//
//  TeamsController+UITableView.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

private let cellId = "cellId"

extension TeamsController {
    
    // Compose and style our TableView
    func setupTableView(){
        tableView.register(TeamCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
    }
    
    // TableView initialization functions
    // -----
    // Header functions
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    // -----
    
    // Body functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TeamCell
        cell.team = teams[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handleDelete)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handleEdit)
        editAction.backgroundColor = .darkBlue
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    // -----
    
    // Footer functions
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No teams available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return teams.count == 0 ? 150 : 0
    }
    // -----
    // -----
    
    // Edit and Delete handler functions
    // -----
    private func handleDelete(action: UITableViewRowAction, indexPath: IndexPath){
        let team = self.teams[indexPath.row]
        // Remove team from tableView
        self.teams.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // Remove team from Core Data
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(team)
        
        do {
            try context.save()
        } catch let saveError {
            print("Error saving deletion: ", saveError)
        }
    }
    
    private func handleEdit(action: UITableViewRowAction, indexPath: IndexPath){
        let editTeamController = CreateTeamController()
        editTeamController.delegate = self
        editTeamController.team = teams[indexPath.row]
        if let foundedYearString = teams[indexPath.row].founded{
            editTeamController.foundedYearString = foundedYearString
        }
        
        let navigationController = CustomNavigationController(rootViewController: editTeamController)
        present(navigationController, animated: true, completion: nil)
    }
    // ----
}
