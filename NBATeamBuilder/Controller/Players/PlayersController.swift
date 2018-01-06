//
//  PlayerController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/4/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

class PlayersController: UITableViewController, CreatePlayerControllerDelegate  {
    
    func didAddPlayer(player: Player) {
        players.append(player)
        tableView.reloadData()
    }
    
    private let cellId = "cellId"
    
    var team: Team?
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupPlusButtoninNavBar(selector: #selector(handleAddPlayer))
        fetchPlayers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = team?.name
    }
    
    
    func fetchPlayers() {
        
        guard let teamPlayers = team?.players?.allObjects as? [Player] else { return }
        self.players = teamPlayers
//        let context = CoreDataManager.shared.persistentContainer.viewContext
//        let request = NSFetchRequest<Player>(entityName: "Player")
//
//        do {
//            let players = try context.fetch(request)
//            self.players = players
//        } catch let fetchError {
//            print("Failed to fetch players: ", fetchError)
//        }
        
    }
    
    @objc private func handleAddPlayer() {
        let createPlayerController = CreatePlayerController()
        createPlayerController.delegate = self
        createPlayerController.team = team
        let navigationController = CustomNavigationController(rootViewController: createPlayerController)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath)
        let player = players[indexPath.row]
        if let position = player.playerBuild?.position {
            cell.textLabel?.text = "\(player.name ?? " ")  -  \(position)"
        } else {
            cell.textLabel?.text = player.name ?? " "
        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .tealBlue
        return cell
    }
    
    
}
