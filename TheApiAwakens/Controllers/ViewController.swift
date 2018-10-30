//
//  ViewController.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/29/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        styleNavigationBar()
    }

    @IBAction func categorySelected(_ sender: UIButton) {
        performSegue(withIdentifier: "showCategory", sender: nil)
    }
    
    /// Style the navigation bar for the navigation controller.
    private func styleNavigationBar() {
        // Make navigation bar background invisible
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        // Change the navigation "Back" text
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        // Change the color of the back button arrow in the navigation bar
        navigationController?.navigationBar.tintColor = UIColor(white: 1.0, alpha: 0.5)
    }
}

