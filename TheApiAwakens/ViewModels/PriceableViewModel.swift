//
//  PriceableViewModel.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// View Model for a Priceable object
struct PriceableViewModel {
    /// Formatter for the cost
    static let costFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.maximumFractionDigits = 2
        return result
    }()
    
    let costInCredits: String
    
    init(priceable: Priceable) {
        self.costInCredits = priceable.costInCredits
    }
    
    /**
     Get the cost in USD.
     
     - Parameter rate: The exhange rate of credits to USD.
     - Returns: The cost in USD. nil if costInCredits can't be converted to a Float. "unknown" for example. nil if rate is not greater than 0.
    */
    func getCostInUsd(rate: Float) -> String? {
        guard let cost = Float(costInCredits) else {
            return costInCredits
        }
        
        guard rate > 0 else {
            return nil
        }
        
        let result = cost * rate
        return PriceableViewModel.costFormatter.string(from: NSNumber(value: result))
    }
}
