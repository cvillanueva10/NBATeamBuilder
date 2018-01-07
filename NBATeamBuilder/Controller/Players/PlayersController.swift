//
//  PlayerController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/4/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

// custom UILabel subclass for custom text drawing
class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = UIEdgeInsetsInsetRect(rect, insets)
        super.drawText(in: customRect)
    }
}

class PlayersController: UITableViewController, CreatePlayerControllerDelegate  {
    
    func didAddPlayer(player: Player) {
        guard let position  = player.playerBuild?.position else { return }
        guard let section = playerPositions.index(of: position) else { return }
        let row = allPlayers[section].count
        let newIndexPath = IndexPath(row: row, section: section )
        allPlayers[section].append(player)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    private let cellId = "cellId"
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupPlusButtoninNavBar(selector: #selector(handleAddPlayer))
        fetchPlayers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = team?.name
    }
    
    var pointGuards = [Player]()
    var shootingGuards = [Player]()
    var smallForwards = [Player]()
    var powerForwards = [Player]()
    var centers = [Player]()
    
    var allPlayers = [[Player]]()
    var playerPositions = [PlayerPosition.PG.rawValue, PlayerPosition.SG.rawValue, PlayerPosition.SF.rawValue, PlayerPosition.PF.rawValue, PlayerPosition.C.rawValue]
    
    func fetchPlayers() {
        guard let teamPlayers = team?.players?.allObjects as? [Player] else { return }
       // self.players = teamPlayers
        
        allPlayers = []
        // use playerPositions array and loop to filter
        playerPositions.forEach { (playerPosition) in
            allPlayers.append(
                teamPlayers.filter {$0.playerBuild?.position == playerPosition}
            )
        }
    }
    
    @objc private func handleAddPlayer() {
        let createPlayerController = CreatePlayerController()
        createPlayerController.delegate = self
        createPlayerController.team = team
        let navigationController = CustomNavigationController(rootViewController: createPlayerController)
        present(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        switch section {
        case 0:
            label.text = "Point Guards"
        case 1:
            label.text = "Shooting Guards"
        case 2:
            label.text = "Small Forwrads"
        case 3:
            label.text = "Power Forwards"
        case 4:
            label.text = "Centers"
        default:
            label.text = ""
        }
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlayers[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath)
        let player = allPlayers[indexPath.section][indexPath.row]
        
        if let age = player.playerInfo?.age {
            cell.textLabel?.text = "\(player.name ?? " ")  - Age: \(age)"
        } else {
            cell.textLabel?.text = player.name ?? " "
        }
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .tealBlue
        return cell
    }
    
    
}
