//
//  Stub.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 10/30/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Stub data to test models without internet connection or parsing JSON
struct Stub {
    static var people: [Person] {
        var luke = Person(
            name: "Luke Skywalker",
            birthYear: "19BBY",
            homeworld: URL(string: "https://swapi.co/api/planets/1/")!,
            height: "172",
            eyeColor: "blue",
            hairColor: "blond",
            starships: [
                URL(string: "https://swapi.co/api/starships/12/")!,
                URL(string: "https://swapi.co/api/starships/22/")!],
            vehicles: [
                URL(string: "https://swapi.co/api/vehicles/14/")!,
                URL(string: "https://swapi.co/api/vehicles/30/")!],
            url: URL(string: "https://swapi.co/api/people/1/")!)
        luke.homeworldObject = Planet(
            name: "Tatooine",
            url: URL(string: "https://swapi.co/api/planets/1/")!)
        luke.starshipObjects = [
            Starship(
                name: "X-wing",
                model: "T-65 X-wing",
                costInCredits: "149999",
                length: "12.5",
                starshipClass: "Starfighter",
                crew: "1",
                url: URL(string: "https://swapi.co/api/starships/12/")!),
            Starship(
                name: "Imperial shuttle",
                model: "Lambda-class T-4a shuttle",
                costInCredits: "240000",
                length: "20",
                starshipClass: "Armed government transport",
                crew: "6",
                url: URL(string: "https://swapi.co/api/starships/22/")!)
        ]
        luke.vehicleObjects = [
            Vehicle(
                name: "Snowspeeder",
                model: "t-47 airspeeder",
                costInCredits: "unknown",
                length: "4.5",
                vehicleClass: "airspeeder",
                crew: "2",
                url: URL(string: "https://swapi.co/api/vehicles/14/")!),
            Vehicle(
                name: "Imperial Speeder Bike",
                model: "74-Z speeder bike",
                costInCredits: "8000",
                length: "3",
                vehicleClass: "speeder",
                crew: "1",
                url: URL(string: "https://swapi.co/api/vehicles/30/")!)
        ]

        var c3po = Person(
            name: "C-3PO",
            birthYear: "112BBY",
            homeworld: URL(string: "https://swapi.co/api/planets/1/")!,
            height: "167",
            eyeColor: "yellow",
            hairColor: "n/a",
            starships: [],
            vehicles: [],
            url: URL(string: "https://swapi.co/api/people/2/")!)
        c3po.homeworldObject = Planet(
            name: "Tatooine",
            url: URL(string: "https://swapi.co/api/planets/1/")!)
        return [luke, c3po]
    }
    
    static var starships: [Starship] {
        let executor = Starship(
            name: "Executor",
            model: "Executor-class star dreadnought",
            costInCredits: "1143350000",
            length: "19000",
            starshipClass: "Star dreadnought",
            crew: "279144",
            url: URL(string: "https://swapi.co/api/starships/15/")!)
        let sentinal = Starship(
            name: "Sentinel-class landing craft",
            model: "Sentinel-class landing craft",
            costInCredits: "240000",
            length: "38",
            starshipClass: "landing craft",
            crew: "5",
            url: URL(string: "https://swapi.co/api/starships/5/")!)
        return [executor, sentinal]
    }
    
    static var vehicles: [Vehicle] {
        let sandcrawler = Vehicle(
            name: "Sand Crawler",
            model: "Digger Crawler",
            costInCredits: "150000",
            length: "36.8",
            vehicleClass: "wheeled",
            crew: "46",
            url: URL(string: "https://swapi.co/api/vehicles/4/")!)
        let skyhopper = Vehicle(
            name: "T-16 skyhopper",
            model: "T-16 skyhopper",
            costInCredits: "14500",
            length: "10.4",
            vehicleClass: "repulsorcraft",
            crew: "1",
            url: URL(string: "https://swapi.co/api/vehicles/6/")!)
        return [sandcrawler, skyhopper]
    }
}
