//
//  TeamsController+CreateTeam.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension TeamsController: CreateTeamControllerDelegate {
    
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
  
}
