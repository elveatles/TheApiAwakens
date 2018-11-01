//
//  VehicleViewModel.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Vehicle View Model
struct VehicleViewModel {
    /// The name of this vehicle. The common name, such as "Death Star".
    let name: String
    /// The model or official name of this vehicle. Such as "T-65 X-wing" or "DS-1 Orbital Battle Station".
    let model: String
    /// The cost of this vehicle new, in galactic credits.
    let costInCredits: String
    /// The class of this vehicle, such as "Starfighter" or "Deep Space Mobile Battlestation"
    let vehicleClass: String
    /// The number of personnel needed to run or pilot this vehicle.
    let crew: String
    
    private let priceableViewModel: PriceableViewModel
    private let measurableViewModel: MeasurableViewModel
    
    init(vehicle: Vehicle) {
        self.name = vehicle.name
        self.model = vehicle.model
        self.vehicleClass = vehicle.vehicleClass
        self.crew = "\(vehicle.crew)"
        
        self.priceableViewModel = PriceableViewModel(priceable: vehicle)
        self.costInCredits = self.priceableViewModel.costInCredits
        self.measurableViewModel = MeasurableViewModel(measurable: vehicle)
    }
    
    func getCostInUsd(rate: Float) -> String? {
        return priceableViewModel.getCostInUsd(rate: rate)
    }
    
    /// Height in metric units
    var lengthInMetricUnits: String {
        return measurableViewModel.lengthInMetricUnits
    }
    
    /// Height in English units
    var lengthInEnglishUnits: String {
        return measurableViewModel.lengthInEnglishUnits
    }
}

