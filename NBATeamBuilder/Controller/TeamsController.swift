//
//  TeamsController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 12/28/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

private let cellId = "cellId"

class TeamsController: UITableViewController, CreateTeamControllerDelegate {

    // Custom Delegate functions
    // -------
    // adds a new team to our tableView
    func didAddTeam(team: Team) {
        teams.append(team)
        let newIndexPath = IndexPath(row: teams.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    // edits the selected team and updated tableView
    func didEditTeam(team: Team) {
        let row = teams.index(of: team)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    // --------
    
    var teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTeams()
        
        navigationItem.title = "Basketball  Teams"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddTeam))
        
        setupTableView()
    }
    
    // Fetch Team objects from Core Data
    private func fetchTeams() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        do {
            let teams = try context.fetch(fetchRequest)
            teams.forEach({ (team) in
                print(team.name ?? "")
            })
            self.teams = teams
            self.tableView.reloadData()
        } catch let fetchError {
            print("Failed to fetch teams:", fetchError)
        }
    }
    
    // Present controller for creating a new team
    // and link it to this controller instance
    @objc func handleAddTeam(){
        let createTeamController = CreateTeamController()
        createTeamController.delegate = self
        let navigationController = CustomNavigationController(rootViewController: createTeamController)
        present(navigationController, animated: true, completion: nil)
    }
   
    // Compose and style our TableView
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        return 50
    }
    
    // Body functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .tealBlue
        
        let team = teams[indexPath.item]
        
//        if let name = team.name{
//            cell.textLabel?.text = "\(name) - Founded: \(founded)"
//        } else {
//            cell.textLabel?.text = team.name
//        }
        if let name = team.name, let founded = team.founded {
              cell.textLabel?.text = "\(name) - Founded: \(founded)"
        } else {
            cell.textLabel?.text = team.name
        }
      
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: handleDelete)
    
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: handleEdit)
        editAction.backgroundColor = .darkBlue
        
        return [deleteAction, editAction]
    }
    
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
        let navigationController = CustomNavigationController(rootViewController: editTeamController)
        present(navigationController, animated: true, completion: nil)
    }
    
    // -----
    
}





