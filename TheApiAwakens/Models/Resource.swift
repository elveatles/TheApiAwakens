//
//  Resource.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/31/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Protocol for a Star Wars API resource
protocol Resource {
    /// The name of the resource
    var name: String { get }
    /// The hypermedia URL of this resource
    var url: URL { get }
}
