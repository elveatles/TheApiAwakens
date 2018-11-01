//
//  PersonViewModel.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Person View Model
struct PersonViewModel {
    /// The name of this person.
    let name: String
    /// The birth year of the person, using the in-universe standard of BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope.
    let birthYear: String
    /// The URL of a planet resource, a planet that this person was born on or inhabits.
    let homeworld: String
    /// The eye color of this person. Will be "unknown" if not known or "n/a" if the person does not have an eye.
    let eyeColor: String
    /// The hair color of this person. Will be "unknown" if not known or "n/a" if the person does not have hair.
    let hairColor: String
    /// Starships that this person has piloted.
    let starships: String
    /// Vehicles this person has piloted.
    let vehicles: String
    
    private let measurableViewModel: MeasurableViewModel
    
    init(person: Person) {
        self.name = person.name
        self.birthYear = person.birthYear
        self.homeworld = person.homeworldObject?.name ?? ""
        self.eyeColor = person.eyeColor
        self.hairColor = person.hairColor
        let starshipNames = person.starshipObjects.map { $0.name }
        self.starships = starshipNames.joined(separator: "\n")
        let vehicleNames = person.vehicleObjects.map { $0.name }
        self.vehicles = vehicleNames.joined(separator: "\n")
        
        self.measurableViewModel = MeasurableViewModel(measurable: person)
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
