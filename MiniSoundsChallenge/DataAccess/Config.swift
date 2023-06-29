//
//  Config.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct Config: Codable {
    var status: Status
    var rmsConfig: RmsConfig
    
    struct Status: Codable {
        var isOn: Bool
        var title: String
        var message: String
        var linkTitle: String
        var appStoreUrl: URL
    }
    
    struct RmsConfig: Codable {
        var apiKey: String
        var rootUrl: URL
        var allStationsPath: String
    }
}
