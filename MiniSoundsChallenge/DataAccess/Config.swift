//
//  Config.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct Config: Codable {
    var status: Status = Status()
    var rmsConfig: RmsConfig = RmsConfig()
    
    struct Status: Codable {
        var isOn: Bool = false
        var title: String = "Default"
        var message: String = "Invalid Config"
        var linkTitle: String = "Link"
        var appStoreUrl: URL = URL(string:"www.bbc.co.uk")!
    }
    
    struct RmsConfig: Codable {
        var apiKey: String = "apiKey"
        var rootUrl: URL = URL(string:"www.bbc.co.uk")!
        var allStationsPath: String = "/notfound"
    }
}
