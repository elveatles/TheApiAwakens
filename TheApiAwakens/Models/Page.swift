//
//  People.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/19/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A page of resources
struct Page<T: Codable>: Codable {
    /// The total number of resources
    let count: Int
    /// The URL for the next page
    let next: URL?
    /// The URL for the previous page
    let previous: URL?
    /// The resources in this page
    let results: [T]
}
