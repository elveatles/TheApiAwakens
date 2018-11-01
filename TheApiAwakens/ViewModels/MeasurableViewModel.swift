//
//  MeasurableViewModel.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A measurable resource for display purposes
struct MeasurableViewModel {
    /// Formatter for the length
    static let lengthFormatter: MeasurementFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        let result = MeasurementFormatter()
        result.numberFormatter = numberFormatter
        result.unitOptions = .providedUnit
        return result
    }()
    
    private let lengthUnits: UnitLength
    private let length: Double
    
    init(measurable: Measurable) {
        self.length = measurable.measurableLength
        self.lengthUnits = measurable.measurableLengthUnits
    }
    
    /// Height in metric units
    var lengthInMetricUnits: String {
        let centimeters = Measurement(value: length, unit: lengthUnits)
        let meters = centimeters.converted(to: UnitLength.meters)
        return MeasurableViewModel.lengthFormatter.string(from: meters)
    }
    
    /// Height in English units
    var lengthInEnglishUnits: String {
        let centimeters = Measurement(value: length, unit: lengthUnits)
        let feet = centimeters.converted(to: UnitLength.feet)
        return MeasurableViewModel.lengthFormatter.string(from: feet)
    }
}
