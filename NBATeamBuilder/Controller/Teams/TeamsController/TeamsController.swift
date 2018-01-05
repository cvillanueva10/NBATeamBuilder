//
//  TeamsController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 12/28/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

class TeamsController: UITableViewController {

    var teams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teams = CoreDataManager.shared.fetchTeams()
        setupTableView()
        setupNavigationItems()
    }
    private func setupNavigationItems() {
        navigationItem.title = "Teams"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        setupPlusButtoninNavBar(selector: #selector(handleAddTeam))
    }
}



