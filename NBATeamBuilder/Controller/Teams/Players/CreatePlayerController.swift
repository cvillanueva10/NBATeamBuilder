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
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter player age"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let playerPositionSegmentedControl: UISegmentedControl = {
        let positions = [PlayerPosition.PG.rawValue, PlayerPosition.SG.rawValue, PlayerPosition.SF.rawValue, PlayerPosition.PF.rawValue, PlayerPosition.C.rawValue]
        let sc = UISegmentedControl(items: positions)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .darkBlue
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
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
        guard let playerAge = ageTextField.text else { return }
        guard let playerPosition = playerPositionSegmentedControl.titleForSegment(at: playerPositionSegmentedControl.selectedSegmentIndex) else { return }

        if playerAge.isEmpty {
           showError(title: "Empty Age", message: "You have not entered an age")
            return
        }
        guard let playerAgeAsInt16 = Int16(playerAge) else {
            showError(title: "Invalid Age", message: "You have entered an invalid age")
            return
        }
        
        let tuple = CoreDataManager.shared.createPlayer(playerName: playerName, position: playerPosition, age: playerAgeAsInt16, team: team)
        
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
    
    private func showError(title: String, message: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setupUI(){
        
        setupLightBlueBackgroundView(height: 150)
        
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
        
        view.addSubview(ageLabel)
        ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        ageLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        ageLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(ageTextField)
        ageTextField.topAnchor.constraint(equalTo: ageLabel.topAnchor).isActive = true
        ageTextField.leftAnchor.constraint(equalTo: ageLabel.rightAnchor).isActive = true
        ageTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        ageTextField.bottomAnchor.constraint(equalTo: ageLabel.bottomAnchor).isActive = true
        
        view.addSubview(playerPositionSegmentedControl)
        playerPositionSegmentedControl.topAnchor.constraint(equalTo: ageLabel.bottomAnchor).isActive = true
        playerPositionSegmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        playerPositionSegmentedControl.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        playerPositionSegmentedControl.heightAnchor.constraint(equalToConstant: 35).isActive = true

    }
}
