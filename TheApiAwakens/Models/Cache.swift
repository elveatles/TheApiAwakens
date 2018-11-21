//
//  Cache.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/20/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Cache of dowloaded Star Wars API objects
struct Cache {
    static var people = [URL: Person]()
    static var starships = [URL: Starship]()
    static var vehicles = [URL: Vehicle]()
    static var planets = [URL: Planet]()
    
    /**
     Cache people.
     
     - Parameter pages: The pages to cache.
    */
    static func cachePeople(pages: [Page<Person>]) {
        Cache.cachePages(cacheVariable: &Cache.people, pages: pages)
    }
    
    /**
     Cache starships.
     
     - Parameter pages: The pages to cache.
     */
    static func cacheStarships(pages: [Page<Starship>]) {
        Cache.cachePages(cacheVariable: &Cache.starships, pages: pages)
    }
    
    /**
     Cache vehicles.
     
     - Parameter pages: The pages to cache.
     */
    static func cacheVehicles(pages: [Page<Vehicle>]) {
        Cache.cachePages(cacheVariable: &Cache.vehicles, pages: pages)
    }
    
    /**
     Cache planets.
     
     - Parameter pages: The pages to cache.
     */
    static func cachePlanets(pages: [Page<Planet>]) {
        Cache.cachePages(cacheVariable: &Cache.planets, pages: pages)
    }
    
    /**
     Assign references to other resources such as Person.homeworld.
     
     This only works if reference objects have been cached.
    */
    static func assignReferences() {
        Cache.people = Cache.people.mapValues { value in
            var person = value
            person.homeworldObject = Cache.planets[value.homeworld]
            person.starshipObjects = person.starships.compactMap { Cache.starships[$0] }
            person.vehicleObjects = person.vehicles.compactMap { Cache.vehicles[$0] }
            return person
        }
    }
    
    /**
     Cache resources.
     
     - Parameter cacheVariable: The variable to store the page results in.
     - Parameter pages: The pages to cache.
     */
    private static func cachePages<T: Resource>(cacheVariable: inout [URL: T], pages: [Page<T>]) {
        for page in pages {
            for resource in page.results {
                cacheVariable[resource.url] = resource
            }
        }
    }
}
