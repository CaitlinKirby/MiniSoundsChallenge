//
//  Stations.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct Stations: Codable {
    var data: [Module] = [Module]()
    //TODO: You shouldn't have to new these up in your model objects, you need to create ListenPageViewModel with this already loaded from the network rather than doing the loading in the view model
    struct Module: Codable {
        var title: String = "Missing Data"
        var data: [StationData] = [StationData]()
        var id: String
            
        struct StationData: Codable {
            var id: String = "Default"
            var titles: Titles = Titles()
            var synopses: Synopses = Synopses()
            var imageUrl: String
            
            struct Titles: Codable {
                var primary: String = "Primary"
                var secondary: String?
                var tertiary: String?
            }
            struct Synopses: Codable {
                var short: String = "Short"
                var medium: String?
                var long: String?
            }
        }
    }
}
