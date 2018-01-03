//
//  CreateTeamController+UIPicker.swift
//  NBATeamBuilder
//
//  Created by Christopher Villanueva on 1/2/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit

extension CreateTeamController {
 
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
