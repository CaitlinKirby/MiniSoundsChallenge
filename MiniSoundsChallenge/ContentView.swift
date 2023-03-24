//
//  ContentView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var config = Config()
    
    func setupJSON(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let decoded = try decoder.decode(Config.self, from: data)
                    config = decoded
                    print(config)
                } catch {
                    print("Failed to decode JSON")
                }
            }
            else if let error = error {
                print("Request failed: \(error)")
            }
        }
        task.resume()
    }
    
    struct MiniSoundsView: View {
        
        let config: Config
        
        var body: some View {
            NavigationView {
                ZStack {
                    Group {
                        Text("Welcome to Mini Sounds!")
                    } .accessibilityHidden(config.status.isOn ? false : true)
                    Group {
                        if(config.status.isOn == false) {
                            // Popup box with a message how it isn't valid
                            VStack {
                                Text(config.status.title)
                                Text(config.status.message)
                                Link(config.status.linkTitle, destination: config.status.appStoreUrl).foregroundColor(.blue)
                            } .accessibilityElement(children: .combine) // Read out all as one rather than individual links
                            .accessibilityLabel(Text("\(config.status.title)  \(config.status.message) \(config.status.linkTitle)"))
                            .padding(10)
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                        }
                    }
                }
                .navigationTitle("BBC Mini Sounds")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MiniSoundsView(config: config).onAppear {
                    setupJSON(url: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/1.15.0/config.json")!)
                }) {
                    Text("Parse killed config")
                }
                .background(.red)
                NavigationLink(destination: MiniSoundsView(config: config).onAppear {
                    setupJSON(url: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/2.3.0/config.json")!)
                }) {
                    Text("Parse live config")
                        .accessibilityLabel(Text("Parse lyve config"))// Use "ii" to make it read the word proper
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
}

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
