//
//  Category.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// The category of the Star Wars collection
enum Category {
    case people
    case starships
    case vehicles
    
    /// Text for UI display
    var text: String {
        switch self {
        case .people: return "Characters"
        case .starships: return "Starships"
        case .vehicles: return "Vehicles"
        }
    }
}
