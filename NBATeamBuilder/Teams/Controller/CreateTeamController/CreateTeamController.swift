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

class CreateTeamController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var teamImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
            
            if let imageData = team?.imageData {
                teamImageView.image = UIImage(data: imageData)
                setupCircularImageStyle()
            }
        }
    }
    
    var delegate: CreateTeamControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        setupUI()
        initializePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ternary syntax (same as if / else)
        navigationItem.title = team == nil ? "Create Team" : "Edit Team"
        
        // this handles setting the picker properly
        // when editing a team
        if let foundedYearInt = Int(foundedYearString){
            let selectedIndex = foundedYearInt - 1947
            foundedPicker.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    func initializePicker() {
        self.foundedPicker.delegate = self
        self.foundedPicker.dataSource = self
    }
}









