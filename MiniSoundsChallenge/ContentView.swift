//
//  ContentView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ListenPageView(configUrl: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/1.15.0/config.json")!)) {
                    Text("Parse killed config")
                }
                .background(.red)
                NavigationLink(destination: ListenPageView(configUrl: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/2.3.0/config.json")!)) {
                    Text("Parse live config")
                        .accessibilityLabel(Text("Parse lyve config"))
                }
                .background(.green)
            }
            .navigationTitle("Config Selections")
            .buttonStyle(.bordered)
            .foregroundColor(.white)
        }
    }
    
}


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


struct Stations: Codable {
    var data: [Module] = [Module]()
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
