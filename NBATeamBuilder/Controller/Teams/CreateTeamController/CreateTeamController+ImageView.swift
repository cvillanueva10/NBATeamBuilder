//
//  CreateTeamController+UIImageView.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension CreateTeamController {
    
    @objc func handleSelectPhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            teamImageView.image = editedImage
        }
        else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            teamImageView.image = originalImage
        }
        setupCircularImageStyle()
        dismiss(animated: true, completion: nil)
    }
    
    func setupCircularImageStyle() {
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamImageView.layer.masksToBounds = true
        teamImageView.layer.borderColor = UIColor.black.cgColor
        teamImageView.layer.borderWidth = 2
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
