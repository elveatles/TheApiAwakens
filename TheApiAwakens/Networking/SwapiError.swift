//
//  SwapiError.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/19/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Error related to the Star Wars API (SWAPI)
enum SwapiError: Error {
    /// Error if HTTP status code can not be pulled from API response
    case requestFailed
    /// Error if API response has an error code
    case invalidData
}
