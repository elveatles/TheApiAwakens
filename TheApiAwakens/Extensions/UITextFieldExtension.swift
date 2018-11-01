//
//  UITextFieldExtension.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/1/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

extension UITextField {
    /// Why doesn't the keyboard have a Done button by default?
    func addDoneButton(target: Any?, action: Selector?) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
    }
}
