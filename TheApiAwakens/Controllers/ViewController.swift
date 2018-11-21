//
//  ViewController.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/29/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Starting view controller where the user can choose the category they want to see.
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        styleNavigationBar()
        // Download resources and cache them
        DownloadManager.downloadCompletion = resourceDownloadsCompleted
        DownloadManager.downloadAllResources()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DownloadManager.downloadCompletion = resourceDownloadsCompleted
    }
    
    @IBAction func selectCharacters() {
        performSegue(withIdentifier: "showCategory", sender: Category.people)
    }
    
    @IBAction func selectVehicles() {
        performSegue(withIdentifier: "showCategory", sender: Category.vehicles)
    }
    
    @IBAction func selectStarships() {
        performSegue(withIdentifier: "showCategory", sender: Category.starships)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategory" {
            // Assign the category to the destination view controller.
            let controller = segue.destination as! CategoryController
            controller.category = sender as! Category
        }
    }
    
    /**
     Convenience function for showing an alert.
     
     - Parameter title: The title of the alert.
     - Parameter message: The alert message.
     */
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
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
        
        // Change the color of the back button arrow
        navigationController?.navigationBar.tintColor = UIColor(white: 1.0, alpha: 0.5)
        
        // Change the size and color of the title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    /// Completion handler for resource downloads
    private func resourceDownloadsCompleted(errors: [Error]) {
        // Only show an alert for one of the errors otherwise the alert will get too cluttered.
        if let error = errors.first {
            showAlert(title: "Resources Download Failed", message: error.localizedDescription)
        }
    }
}

