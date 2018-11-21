//
//  StatsController.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// Stats about a Person, Starship, or Vehicle
class StatsController: UITableViewController {
    enum CostIndex: Int {
        case usd
        case credits
    }
    
    enum LengthIndex: Int {
        case english
        case metric
    }
    
    @IBOutlet weak var cell0KeyLabel: UILabel!
    @IBOutlet weak var cell0ValueLabel: UILabel!
    @IBOutlet weak var cell1KeyLabel: UILabel!
    @IBOutlet weak var cell1ValueLabel: UILabel!
    @IBOutlet weak var costSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cell2KeyLabel: UILabel!
    @IBOutlet weak var cell2ValueLabel: UILabel!
    @IBOutlet weak var lengthSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cell3KeyLabel: UILabel!
    @IBOutlet weak var cell3ValueLabel: UILabel!
    @IBOutlet weak var cell4KeyLabel: UILabel!
    @IBOutlet weak var cell4ValueLabel: UILabel!
    @IBOutlet weak var vehiclesCell: UITableViewCell!
    @IBOutlet weak var vehiclesValueLabel: UILabel!
    @IBOutlet weak var starshipsCell: UITableViewCell!
    @IBOutlet weak var starshipsValueLabel: UILabel!
    
    var category = Category.people
    /// The exchange rate of credits to USD
    var creditsToUsdRate: Float = 0.5
    /// The current resource (Person, Starship, Vehicle)
    private var currentResource: Resource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide the extra rows at the bottom
        tableView.tableFooterView = UIView()
        
        styleSegmentedControl(costSegmentedControl)
        styleSegmentedControl(lengthSegmentedControl)
        
        // Make values question marks when a resource has not been shown yet
        cell0ValueLabel.text = "???"
        cell1ValueLabel.text = "???"
        cell2ValueLabel.text = "???"
        cell3ValueLabel.text = "???"
        cell4ValueLabel.text = "???"
        vehiclesValueLabel.text = "???"
        starshipsValueLabel.text = "???"
        
        if category != .people {
            vehiclesCell.isHidden = true
            starshipsCell.isHidden = true
        }
    }
    
    @IBAction func changeCostUnits() {
        updateCost()
    }
    
    @IBAction func changeLengthUnits() {
        updateLength()
    }
    
    /**
     Show stats for a resource (person, starship, vehicle).
     
     - Parameter resource: The resource to show.
    */
    func showResource(_ resource: Resource) {
        if let person = resource as? Person {
            showResource(person: person)
        } else if let starship = resource as? Starship {
            showResource(starship: starship)
        } else if let vehicle = resource as? Vehicle {
            showResource(vehicle: vehicle)
        } else {
            print("StatsController.showResource: resource type not recognized. Should be Person, Starsip, Vehicle")
        }
    }
    
    /**
     Show stats for a person.
     
     - Parameter person: The person to show.
    */
    func showResource(person: Person) {
        currentResource = person
        let viewModel = PersonViewModel(person: person)
        
        // This updates the automatic row height for cells
        tableView.beginUpdates()
        
        cell0KeyLabel.text = "Born"
        cell0ValueLabel.text = viewModel.birthYear
        cell1KeyLabel.text = "Home"
        cell1ValueLabel.text = viewModel.homeworld
        costSegmentedControl.isHidden = true
        cell2KeyLabel.text = "Height"
        updateLength()
        lengthSegmentedControl.isHidden = false
        cell3KeyLabel.text = "Eyes"
        cell3ValueLabel.text = viewModel.eyeColor
        cell4KeyLabel.text = "Hair"
        cell4ValueLabel.text = viewModel.hairColor
        vehiclesValueLabel.text = viewModel.vehicles
        starshipsValueLabel.text = viewModel.starships
        
        tableView.endUpdates()
    }
    
    /**
     Show stats for a starship.
     
     - Parameter starship: The starship to show.
    */
    func showResource(starship: Starship) {
        currentResource = starship
        let viewModel = StarshipViewModel(starship: starship)
        
        cell0KeyLabel.text = "Make"
        cell0ValueLabel.text = viewModel.model
        cell1KeyLabel.text = "Cost"
        updateCost()
        costSegmentedControl.isHidden = false
        cell2KeyLabel.text = "Length"
        updateLength()
        lengthSegmentedControl.isHidden = false
        cell3KeyLabel.text = "Class"
        cell3ValueLabel.text = viewModel.starshipClass
        cell4KeyLabel.text = "Crew"
        cell4ValueLabel.text = viewModel.crew
    }
    
    /**
     Show stats for a vehicle.
     
     - Parameter vehicle: The vehicle to show.
    */
    func showResource(vehicle: Vehicle) {
        currentResource = vehicle
        let viewModel = VehicleViewModel(vehicle: vehicle)
        
        cell0KeyLabel.text = "Make"
        cell0ValueLabel.text = viewModel.model
        cell1KeyLabel.text = "Cost"
        updateCost()
        costSegmentedControl.isHidden = false
        cell2KeyLabel.text = "Length"
        updateLength()
        lengthSegmentedControl.isHidden = false
        cell3KeyLabel.text = "Class"
        cell3ValueLabel.text = viewModel.vehicleClass
        cell4KeyLabel.text = "Crew"
        cell4ValueLabel.text = viewModel.crew
    }
    
    /// Update the cost based on the currency and exchange rate
    func updateCost() {
        guard let resource = currentResource else {
            print("StatsController.updateCost: currentResource is nil.")
            return
        }
        
        guard let priceable = resource as? Priceable else {
            print("StatsController.updateCost: currentResource is not Priceable.")
            return
        }
        
        let viewModel = PriceableViewModel(priceable: priceable)
        
        if costSegmentedControl.selectedSegmentIndex == CostIndex.usd.rawValue {
            cell1ValueLabel.text = viewModel.getCostInUsd(rate: creditsToUsdRate)
        } else {
            cell1ValueLabel.text = viewModel.costInCredits
        }
    }
    
    /// Update the length based on the chosen unit conversion
    func updateLength() {
        guard let resource = currentResource else {
            print("StatsController.updateLength: currentResource is nil.")
            return
        }
        
        guard let measurable = resource as? Measurable else {
            print("StatsController.updateLength: currentResource is not Measurable.")
            return
        }
        
        let viewModel = MeasurableViewModel(measurable: measurable)
        
        if lengthSegmentedControl.selectedSegmentIndex == LengthIndex.english.rawValue {
            cell2ValueLabel.text = viewModel.lengthInEnglishUnits
        } else {
            cell2ValueLabel.text = viewModel.lengthInMetricUnits
        }
    }
    
    /**
     Style a segmented control in this view controller.
     
     - Parameter control: The control to style.
    */
    private func styleSegmentedControl(_ control: UISegmentedControl) {
        control.backgroundColor = .clear
        control.tintColor = .clear
        var textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.3)
        ]
        control.setTitleTextAttributes(textAttributes, for: .normal)
        textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        control.setTitleTextAttributes(textAttributes, for: .selected)
    }
}
