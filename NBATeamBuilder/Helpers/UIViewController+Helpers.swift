//
//  UIViewController+Helpers.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/4/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupPlusButtoninNavBar(selector: Selector){
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupSaveButtonInNavBar(selector: Selector){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: selector)
    }
    
    
    func setupLightBlueBackgroundView(height: CGFloat) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightBlue
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
}
