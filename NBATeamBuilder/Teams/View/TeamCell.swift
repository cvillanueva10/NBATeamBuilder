//
//  TeamCell.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    let teamImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedYearLabel: UILabel = {
        let label = UILabel()
        label.text = "TEAM NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var team: Team? {
        didSet {
            if let imageData = team?.imageData {
                teamImageView.image = UIImage(data: imageData)
            }
            if let name = team?.name, let founded = team?.founded {
                nameFoundedYearLabel.text = "\(name) - Founded: \(founded)"
            } else {
                nameFoundedYearLabel.text = team?.name
            }
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    private func setupViews() {
        
        backgroundColor = .tealBlue
        
        addSubview(teamImageView)
        teamImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        teamImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        teamImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        teamImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addSubview(nameFoundedYearLabel)
        nameFoundedYearLabel.leftAnchor.constraint(equalTo: teamImageView.rightAnchor, constant: 16).isActive = true
        nameFoundedYearLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameFoundedYearLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameFoundedYearLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






