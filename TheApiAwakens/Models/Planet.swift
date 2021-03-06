//
//  Planet.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A Planet resource is a large mass, planet or planetoid in the Star Wars Universe, at the time of 0 ABY.
struct Planet: Codable, Resource {
    /// The name of this planet.
    let name: String
    /// The hypermedia URL of this resource
    let url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
