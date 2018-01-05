//
//  CreateTeamController+SetupUI.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension CreateTeamController {
    
    // Set up our UI components using auto layout constraints
    func setupUI(){
        
        setupLightBlueBackgroundView(height: 250)
        
        view.addSubview(teamImageView)
        teamImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        teamImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        teamImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: teamImageView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        view.addSubview(foundedLabel)
        foundedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        foundedLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        foundedLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        foundedLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(foundedPicker)
        foundedPicker.topAnchor.constraint(equalTo: foundedLabel.topAnchor).isActive = true
        foundedPicker.leftAnchor.constraint(equalTo: foundedLabel.rightAnchor).isActive = true
        foundedPicker.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        foundedPicker.bottomAnchor.constraint(equalTo: foundedLabel.bottomAnchor).isActive = true
    }
}
