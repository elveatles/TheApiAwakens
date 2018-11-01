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
        guard let measurables = resourcePickerDataSource.data as? [Measurable] else {
            return nil
        }
        
        let result = measurables.min { $0.measurableLength < $1.measurableLength }
        return result as? Resource
    }
    
    /// The largest resource. nil if current resources are not Measurable. nil if there are no resources.
    var largestResource: Resource? {
        // Get current resources as Measurable objects
        guard let measurables = resourcePickerDataSource.data as? [Measurable] else {
            return nil
        }
        
        let result = measurables.max { $0.measurableLength < $1.measurableLength }
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
        if let rate = exchangeRate {
            statsController.creditsToUsdRate = rate
        }
        
        query()
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
            return
        }
        
        statsController.creditsToUsdRate = rate
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
     Query resources from the Star Wars API.
    */
    func query() {
        switch category {
        case .people: update(resources: Stub.people)
        case .starships: update(resources: Stub.starships)
        case .vehicles: update(resources: Stub.vehicles)
        }
    }
    
    /**
     Update this view controller with new resources.
     
     - Parameter resources: The resources to update with.
    */
    func update(resources: [Resource]) {
        resourcePickerDataSource.data = resources
        
        if let first = resources.first {
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
}

extension CategoryController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return resourcePickerDataSource.data[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let resource = resourcePickerDataSource.data[row]
        showResource(resource)
    }
}