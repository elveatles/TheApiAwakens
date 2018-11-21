//
//  Measurable.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Protocol for an object that can be measured in length.
protocol Measurable {
    /// The units that measurableLength is in.
    var measurableLengthUnits: UnitLength { get }
    /// The length of this object.
    var measurableLength: Double? { get }
    /// The length as a string. Can be "unknown"
    var measurableLengthString: String { get }
}
