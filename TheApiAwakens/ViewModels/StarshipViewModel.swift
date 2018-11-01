//
//  StarshipViewModel.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Starship View Model
struct StarshipViewModel {
    /// The name of this starship. The common name, such as "Death Star".
    let name: String
    /// The model or official name of this starship. Such as "T-65 X-wing" or "DS-1 Orbital Battle Station".
    let model: String
    /// The cost of this starship new, in galactic credits.
    let costInCredits: String
    /// The class of this starship, such as "Starfighter" or "Deep Space Mobile Battlestation"
    let starshipClass: String
    /// The number of personnel needed to run or pilot this starship.
    let crew: String
    
    private let priceableViewModel: PriceableViewModel
    private let measurableViewModel: MeasurableViewModel
    
    init(starship: Starship) {
        self.name = starship.name
        self.model = starship.model
        self.starshipClass = starship.starshipClass
        self.crew = "\(starship.crew)"
        
        self.priceableViewModel = PriceableViewModel(priceable: starship)
        self.costInCredits = self.priceableViewModel.costInCredits
        self.measurableViewModel = MeasurableViewModel(measurable: starship)
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
