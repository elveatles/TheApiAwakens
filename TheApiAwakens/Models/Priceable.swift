//
//  Priceable.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Protocol for object that has a price.
protocol Priceable {
    /// The cost in credits. Value can be "unknown" which is why it is a String.
    var costInCredits: String { get }
}
