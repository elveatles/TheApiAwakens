//
//  SwapiClient.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/19/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Client for the Star Wars REST API (SWAPI)
class SwapiClient {
    typealias PeopleCallback = (Page<Person>?, Error?) -> Void
    typealias AllPeopleCallback = ([Page<Person>]?, Error?) -> Void
    typealias AllStarshipsCallback = ([Page<Starship>]?, Error?) -> Void
    typealias AllVehiclesCallback = ([Page<Vehicle>]?, Error?) -> Void
    typealias AllPlanetsCallback = ([Page<Planet>]?, Error?) -> Void
    
    private static let session = URLSession(configuration: .default)
    private static let decoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        return result
    }()
    
    /*
     Download every page for people.
     
     - Parameter completion: The callback for when the download and decode completes.
    */
    static func allPeople(completion: @escaping AllPeopleCallback) {
        let endpoint = SwapiEndpoint.people
        let pages = [Page<Person>]()
        SwapiClient.downloadAllResources(url: endpoint.url, pages: pages, completion: completion)
    }
    
    /*
     Download every page for starships.
     
     - Parameter completion: The callback for when the download and decode completes.
     */
    static func allStarships(completion: @escaping AllStarshipsCallback) {
        let endpoint = SwapiEndpoint.starships
        let pages = [Page<Starship>]()
        SwapiClient.downloadAllResources(url: endpoint.url, pages: pages, completion: completion)
    }
    
    /*
     Download every page for vehicles.
     
     - Parameter completion: The callback for when the download and decode completes.
     */
    static func allVehicles(completion: @escaping AllVehiclesCallback) {
        let endpoint = SwapiEndpoint.vehicles
        let pages = [Page<Vehicle>]()
        SwapiClient.downloadAllResources(url: endpoint.url, pages: pages, completion: completion)
    }
    
    /*
     Download every page for planets.
     
     - Parameter completion: The callback for when the download and decode completes.
     */
    static func allPlanets(completion: @escaping AllPlanetsCallback) {
        let endpoint = SwapiEndpoint.planets
        let pages = [Page<Planet>]()
        SwapiClient.downloadAllResources(url: endpoint.url, pages: pages, completion: completion)
    }
    
    /**
     Generic method for downloading all pages for a resource (people, starships, vehicles, etc.) then decoding.
     
     - Parameter url: The URL to download from.
     - Parameter pages: The aggregate pages.
     - Parameter completion: Callback to call when all pages have finished downloading and decoding.
    */
    private static func downloadAllResources<T>(url: URL, pages: [Page<T>], completion: @escaping ([Page<T>]?, Error?) -> Void) {
        var result = pages
        SwapiClient.downloadResources(url: url) { (page: Page<T>?, error: Error?) in
            if let p = page {
                result.append(p)
                if let next = p.next {
                    SwapiClient.downloadAllResources(url: next, pages: result, completion: completion)
                } else {
                    completion(result, nil)
                }
            } else if let e = error {
                completion(nil, e)
            }
        }
    }
    
    /**
     Generic method for download a resource (people, starships, vehicles, etc.) then decoding it.
     
     - Parameter url: The URL to download from.
     - Parameter completion: The completion callback with either a page of resources or an error.
    */
    private static func downloadResources<T>(url: URL, completion: @escaping (Page<T>?, Error?) -> Void) {
        let request = URLRequest(url: url)
        let task = SwapiClient.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SwapiError.requestFailed)
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let people = try SwapiClient.decoder.decode(Page<T>.self, from: data)
                            completion(people, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, SwapiError.responseUnsuccessful)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
