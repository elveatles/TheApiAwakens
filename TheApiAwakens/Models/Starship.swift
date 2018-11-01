//
//  Starship.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A single transport craft that has hyperdrive capability.
struct Starship: Codable, Resource, Measurable, Priceable {
    /// The name of this starship. The common name, such as "Death Star".
    let name: String
    /// The model or official name of this starship. Such as "T-65 X-wing" or "DS-1 Orbital Battle Station".
    let model: String
    /// The cost of this starship new, in galactic credits. Can be "unknown".
    let costInCredits: String
    /// The length of this starship in meters.
    let length: Float
    /// The class of this starship, such as "Starfighter" or "Deep Space Mobile Battlestation"
    let starshipClass: String
    /// The number of personnel needed to run or pilot this starship.
    let crew: Int
    
    init(name: String, model: String, costInCredits: String, length: Float, starshipClass: String, crew: Int) {
        self.name = name
        self.model = model
        self.costInCredits = costInCredits
        self.length = length
        self.starshipClass = starshipClass
        self.crew = crew
    }
    
    var measurableLengthUnits: UnitLength {
        return .meters
    }
    
    var measurableLength: Double {
        return Double(length)
    }
}
