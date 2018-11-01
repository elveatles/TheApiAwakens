//
//  Person.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// An individual person or character within the Star Wars universe.
struct Person: Codable, Resource, Measurable {
    /// The name of this person.
    let name: String
    /// The birth year of the person, using the in-universe standard of BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope.
    let birthYear: String
    /// The URL of a planet resource, a planet that this person was born on or inhabits.
    let homeworld: URL
    /// The height of the person in centimeters.
    let height: Int
    /// The eye color of this person. Will be "unknown" if not known or "n/a" if the person does not have an eye.
    let eyeColor: String
    /// The hair color of this person. Will be "unknown" if not known or "n/a" if the person does not have hair.
    let hairColor: String
    /// An array of starship resource URLs that this person has piloted.
    let starships: [URL]
    /// An array of vehicle resource URLs that this person has piloted.
    let vehicles: [URL]

    /// Data retrieved from the homeworld URL.
    var homeworldObject: Planet?
    var starshipObjects = [Starship]()
    var vehicleObjects = [Vehicle]()
    
    init(name: String, birthYear: String, homeworld: URL, height: Int, eyeColor: String, hairColor: String, starships: [URL], vehicles: [URL]) {
        self.name = name
        self.birthYear = birthYear
        self.homeworld = homeworld
        self.height = height
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.starships = starships
        self.vehicles = vehicles
    }
    
    var measurableLengthUnits: UnitLength {
        return .centimeters
    }
    
    var measurableLength: Double {
        return Double(height)
    }
}
