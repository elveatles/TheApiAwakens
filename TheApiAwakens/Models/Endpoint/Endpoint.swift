//
//  Endpoint.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/19/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// A generic REST API Endpoint
protocol Endpoint {
    /// The base of the URL
    var base: String { get }
    /// The path of the URL
    var path: String { get }
    /// Any key value pairs in the URL query
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    /// Get the URL components based on the endpoint properties
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    /// Get the URL for this endpoint
    var url: URL {
        return urlComponents.url!
    }
    
    /// Create a URL Request based on the endpoint properties
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

/// Star Wars API (SWAPI) endpoint.
enum SwapiEndpoint {
    case people
    case starships
    case vehicles
    case planets
}

extension SwapiEndpoint: Endpoint {
    var base: String {
        return "https://swapi.co"
    }
    
    var path: String {
        switch self {
        case .people: return "/api/people/"
        case .starships: return "/api/starships/"
        case .vehicles: return "/api/vehicles/"
        case .planets: return "/api/planets/"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .people: return nil
        case .starships: return nil
        case .vehicles: return nil
        case .planets: return nil
        }
    }
}
