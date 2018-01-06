//
//  CreatePlayerController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/4/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

protocol CreatePlayerControllerDelegate {
    func didAddPlayer(player: Player)
}

class CreatePlayerController: UIViewController {
    
    var delegate: CreatePlayerControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter player name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var team: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Player"
        view.backgroundColor = .darkBlue
        
        // helper functions
        setupCancelButtonInNavBar()
        setupSaveButtonInNavBar(selector: #selector(handleSave))
        setupUI()
    }
    
    @objc private func handleSave(){
        
        guard let playerName = nameTextField.text else { return }
        guard let team = self.team else { return }
        let tuple = CoreDataManager.shared.createPlayer(playerName: playerName, team: team)
        
        if let error = tuple.1 {
             // present error using something
            print(error)
        } else {
            dismiss(animated: true, completion: {
            // call delegate
            guard let player = tuple.0 else {return}
            self.delegate?.didAddPlayer(player: player)
            })
        }
    }
    
    func setupUI(){
        
        setupLightBlueBackgroundView(height: 50)
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true

    }
}
