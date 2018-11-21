//
//  Vehicle.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A single transport craft that does not have hyperdrive capability.
struct Vehicle: Codable, Resource, Measurable, Priceable {
    /// The name of this vehicle. The common name, such as "Sand Crawler" or "Speeder bike".
    let name: String
    /// The model or official name of this vehicle. Such as "All-Terrain Attack Transport".
    let model: String
    /// The cost of this vehicle new, in Galactic Credits. Can be "unknown".
    let costInCredits: String
    /// The length of this vehicle in meters.
    let length: String
    /// The class of this vehicle, such as "Wheeled" or "Repulsorcraft".
    let vehicleClass: String
    /// The number of personnel needed to run or pilot this vehicle.
    let crew: String
    /// The hypermedia URL of this resource
    let url: URL
    
    init(name: String, model: String, costInCredits: String, length: String, vehicleClass: String, crew: String, url: URL) {
        self.name = name
        self.model = model
        self.costInCredits = costInCredits
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
        self.url = url
    }
    
    var measurableLengthUnits: UnitLength {
        return .meters
    }
    
    var measurableLength: Double? {
        return Double(length)
    }
    
    var measurableLengthString: String {
        return length
    }
}
