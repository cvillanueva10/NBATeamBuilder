//
//  CreateTeamsController.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 12/28/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegation
protocol CreateTeamControllerDelegate {
    func didAddTeam(team: Team)
    func didEditTeam(team: Team)
}

class CreateTeamController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter team name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let foundedLabel: UILabel = {
        let label = UILabel()
        label.text = "Founded"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var foundedPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var foundedYearString = "1947" // default year
    let foundedPickerData = Array(1947...2018)
    
    var team: Team? {
        didSet {
            nameTextField.text = team?.name

        }
    }
    
    var delegate: CreateTeamControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
        setupPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ternary syntax (same as if / else)
        navigationItem.title = team == nil ? "Create Team" : "Edit Team"
        if let foundedYearInt = Int(foundedYearString){
            let selectedIndex = foundedYearInt - 1947
            foundedPicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    // Set up our UI components using auto layout constraints
    private func setupUI(){
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
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
    
    private func setupPicker() {
        self.foundedPicker.delegate = self
        self.foundedPicker.dataSource = self
    }
    
    // Dismiss current controller and add team
    // to TeamsController tableView and save to Core Data
    @objc private func handleSave() {
        if team == nil {
            createTeam()
        } else {
            saveTeamChanges()
        }
    }
    
    private func createTeam(){
        // initialization of Core Data stack
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: context)
        team.setValue(nameTextField.text, forKey: "name")
        team.setValue(foundedYearString, forKey: "founded")
        
        // Save team object
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didAddTeam(team: team as! Team)
            })
        } catch let saveError {
            print("Failed to save team:", saveError)
        }
    }
    
    private func saveTeamChanges(){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        team?.name = nameTextField.text
        team?.founded = foundedYearString
        
        do {
            try context.save()
            dismiss(animated: true, completion: {
                self.delegate?.didEditTeam(team: self.team!)
            })
        } catch let saveError {
            print("Error updating team: ", saveError)
        }
    }
    
    // Dismiss current controller
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    // Picker functions
    // -------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2017 - 1947 + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = "\(foundedPickerData[row])"
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        foundedYearString = "\(foundedPickerData[row])"
    }
    // -------
    
}









