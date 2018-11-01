//
//  KeyboardManager.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/1/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Manage the software keyboard
class KeyboardManager {
    /**
     Move the root view up if a text field is being blocked by the software keyboard.
     
     - Parameter notification: The notification from UIResponder.keyboardWillShowNotification.
     - Parameter textField: The text field being edited.
     - Parameter rootView: The root view that the text field is in.
    */
    static func keyboardWillShow(notification: Notification, textField: UITextField, rootView: UIView) {
        var firstResponderFrame = textField.frame
        // Convert first responder frame to global coordinates if it is a nested subview
        if let firstResponderSuperView = textField.superview, firstResponderSuperView != rootView {
            firstResponderFrame = firstResponderSuperView.convert(textField.frame, to: rootView)
        }
        
        // Move view so text field is not hidden by the software keyboard
        if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue
            if frame.intersects(firstResponderFrame) {
                rootView.frame.origin.y = -frame.size.height
            }
        }
    }
    
    /**
     Move the root view back to its original position.
     
     - Parameter notification: The notification from UIResponder.keyboardWillHideNotification.
     - Parameter textField: The text field being edited.
     - Parameter rootView: The root view that the text field is in.
     */
    static func keyboardWillHide(notification: Notification, rootView: UIView) {
        // Move view back to the origin
        rootView.frame.origin.y = 0
    }
}
