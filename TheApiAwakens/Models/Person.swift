//
//  Person.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// An individual person or character within the Star Wars universe.
struct Person: Codable {
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
    
    /// Data retrieved from the homeworld URL.
    var homeworldPlanet: Planet
}
