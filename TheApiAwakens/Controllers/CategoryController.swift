//
//  CategoryController.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// View Controller for a category (people, starships, vehicles).
class CategoryController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var exchangeRateTextField: UITextField!
    @IBOutlet weak var resourcePicker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    /// The category (person, starship, vehicle) chosen for this view controller.
    var category = Category.people
    
    private weak var statsController: StatsController!
    private let numberTextFieldDelegate = NumberTextFieldDelegate()
    private let resourcePickerDataSource = ResourcePickerDataSource()
    
    /// Convenient way to get exchange rate as Float from the exchangeRateTextField
    var exchangeRate: Float? {
        guard let text = exchangeRateTextField.text else {
            return nil
        }
        
        return Float(text)
    }
    
    /// The smallest resource. nil if current resources are not Measurable. nil if there are no resources.
    var smallestResource: Resource? {
        // Get current resources as Measurable objects
        guard var measurables = resourcePickerDataSource.data as? [Measurable] else {
            return nil
        }
        
        measurables = measurables.filter { $0.measurableLength != nil }
        // Force unwrapping because the line above filters out nil values
        let result = measurables.min { $0.measurableLength! < $1.measurableLength! }
        return result as? Resource
    }
    
    /// The largest resource. nil if current resources are not Measurable. nil if there are no resources.
    var largestResource: Resource? {
        // Get current resources as Measurable objects
        guard var measurables = resourcePickerDataSource.data as? [Measurable] else {
            return nil
        }
        
        measurables = measurables.filter { $0.measurableLength != nil }
        let result = measurables.max { $0.measurableLength! < $1.measurableLength! }
        return result as? Resource
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add notification observers for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Set data sources and delegates
        exchangeRateTextField.delegate = numberTextFieldDelegate
        resourcePicker.dataSource = resourcePickerDataSource
        resourcePicker.delegate = self
        
        navigationItem.title = category.text
        exchangeRateTextField.addDoneButton(target: self, action: #selector(keyboardDone))
        exchangeRateLabel.isHidden = category == .people
        exchangeRateTextField.isHidden = category == .people
        
        if let rate = UserDefaults.standard.value(forKey: "creditsToUsdRate") as? Float {
            exchangeRateTextField.text = "\(rate)"
        }
        
        activityIndicator.hidesWhenStopped = true
        
        // Assign callback method if resources are still downloading,
        // otherwise update with the cached resource downloads.
        if DownloadManager.isDownloading {
            activityIndicator.startAnimating()
            DownloadManager.downloadCompletion = resourceDownloadsCompleted
        } else {
            activityIndicator.stopAnimating()
            update()
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "embedStats" {
            // Store a reference to the stats view controller
            statsController = segue.destination as? StatsController
            statsController.category = category
        }
    }
    
    /// Update the cost based on the new exchange rate.
    @IBAction func exchangeRateChanged(_ sender: UITextField) {
        guard let rate = exchangeRate else {
            return
        }
        
        // Make sure value is greater than 0
        guard rate > 0 else {
            showAlert(title: "Exchange Rate", message: "Exchange rate should be greater than 0.")
            // Change value back to old value
            let oldRateOpt = UserDefaults.standard.value(forKey: "creditsToUsdRate") as? Float
            var oldRate = oldRateOpt ?? 1.0
            // Extra safety
            if oldRate <= 0.0 {
                oldRate = 1.0
            }
            exchangeRateTextField.text = "\(oldRate)"
            return
        }
        
        UserDefaults.standard.set(rate, forKey: "creditsToUsdRate")
        statsController.updateCost()
    }
    
    /// Hide the keyboard when editing is done.
    @objc func keyboardDone() {
        exchangeRateTextField.resignFirstResponder()
    }
    
    /// Make sure keyboard does not block the text field.
    @objc func keyboardWillShow(_ notification: Notification) {
        KeyboardManager.keyboardWillShow(notification: notification, textField: exchangeRateTextField, rootView: view)
    }
    
    /// Move the root view back down since the keyboard will be hidden.
    @objc func keyboardWillHide(_ notification: Notification) {
        KeyboardManager.keyboardWillHide(notification: notification, rootView: view)
    }
    
    /**
     Update this view controller with new resources.
    */
    func update() {
        // Assign picker data based on category
        switch category {
        case .people:
            resourcePickerDataSource.data = Cache.people.values.sorted { $0.name < $1.name }
        case .starships:
            resourcePickerDataSource.data = Cache.starships.values.sorted { $0.name < $1.name }
        case .vehicles:
            resourcePickerDataSource.data = Cache.vehicles.values.sorted { $0.name < $1.name }
        }
        
        // resourcePickerDataSource.data = resources
        resourcePicker.reloadAllComponents()
        
        if let first = resourcePickerDataSource.data.first {
            showResource(first)
        }
    }
    
    /**
     Show a single resource (person, starship, vehicle).
     
     - Parameter resource: The resource to show.
    */
    func showResource(_ resource: Resource) {
        nameLabel.text = resource.name
        
        guard let stats = statsController else {
            print("CategoryController.showResource: statsController is nil")
            return
        }
        
        stats.showResource(resource)
        smallestLabel.text = smallestResource?.name
        largestLabel.text = largestResource?.name
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
    
    /// Completion handler for resource downloads
    private func resourceDownloadsCompleted(errors: [Error]) {
        activityIndicator.stopAnimating()
        
        // Only show an alert for one of the errors otherwise the alert will get too cluttered.
        if let error = errors.first {
            showAlert(title: "Resources Download Failed", message: error.localizedDescription)
        } else {
            update()
        }
    }
}

extension CategoryController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return resourcePickerDataSource.data[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard resourcePickerDataSource.data.count > 0 else {
            return
        }
        
        let resource = resourcePickerDataSource.data[row]
        showResource(resource)
    }
}
