//
//  DownloadManager.swift
//  TheApiAwakens
//
//  Created by Erik Carlson on 11/20/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// High level management for downloading and caching using the Star Wars API
class DownloadManager {
    /// Check if resources are being downloaded
    static var isDownloading: Bool {
        return _isDownloading
    }
    /// Download completion handler. Results are cached. Errors are combined from all resource downloads.
    static var downloadCompletion: (([Error]) -> Void)?
    
    private static var _isDownloading = false
    
    /// Download all resources and cache the results.
    static func downloadAllResources() {
        _isDownloading = true
        // Use DispatchGroup so we know when all async tasks are done
        let group = DispatchGroup()
        var errors = [Error]()
        
        // people
        group.enter()
        SwapiClient.allPeople { (pages, error) in
            if let p = pages {
                Cache.cachePeople(pages: p)
            } else if let e = error {
                errors.append(e)
            }
            
            group.leave()
        }
        
        // starships
        group.enter()
        SwapiClient.allStarships { (pages, error) in
            if let p = pages {
                Cache.cacheStarships(pages: p)
            } else if let e = error {
                errors.append(e)
            }
            
            group.leave()
        }
        
        // vehicles
        group.enter()
        SwapiClient.allVehicles { (pages, error) in
            if let p = pages {
                Cache.cacheVehicles(pages: p)
            } else if let e = error {
                errors.append(e)
            }
            
            group.leave()
        }
        
        // planets
        group.enter()
        SwapiClient.allPlanets { (pages, error) in
            if let p = pages {
                Cache.cachePlanets(pages: p)
            } else if let e = error {
                errors.append(e)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            _isDownloading = false
            Cache.assignReferences()
            
            if let completion = downloadCompletion {
                completion(errors)
            }
        }
    }
}
