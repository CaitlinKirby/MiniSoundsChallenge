//
//  Stations.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct Stations: Codable {
    var data: [Module]
    
    struct Module: Codable {
        var title: String
        var data: [StationData]
        var id: String
            
        struct StationData: Codable {
            var id: String
            var titles: Titles
            var synopses: Synopses
            var image_url: String
            
            struct Titles: Codable {
                var primary: String
                var secondary: String?
                var tertiary: String?
            }
            struct Synopses: Codable {
                var short: String
                var medium: String?
                var long: String?
            }
        }
    }
}
