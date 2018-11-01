//
//  NumberTextFieldDelegate.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Delegate for text fields which only allow positive numbers (Int, Float, or Double).
class NumberTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Unwrap optional values
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            // Getting to this point is really unlikely
            return true
        }
        
        // Check if the string being added has any characters that are not numbers or decimal
        var numberCharacters = CharacterSet.decimalDigits
        numberCharacters.insert(".")
        if !numberCharacters.isSuperset(of: CharacterSet(charactersIn: string)) {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        // Check if there is more than one decimal
        let numberOfDecimals = updatedText.filter { $0 == "." }.count
        if numberOfDecimals > 1 {
            return false
        }
        
        return true
    }
}
