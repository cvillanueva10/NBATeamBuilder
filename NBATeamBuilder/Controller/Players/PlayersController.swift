//
//  PlayerController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/4/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

class PlayersController: UITableViewController {
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBlue
        
        setupPlusButtoninNavBar(selector: #selector(handleAddPlayer))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = team?.name
    }
    
    @objc private func handleAddPlayer() {
        let createPlayerController = CreatePlayerController()
        let navigationController = CustomNavigationController(rootViewController: createPlayerController)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    
}
