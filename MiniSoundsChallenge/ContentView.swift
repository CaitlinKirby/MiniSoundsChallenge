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
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("Parse killed config 💀") {
                        setupJSON(url: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/1.15.0/config.json")!)
                    } .buttonStyle(.bordered)

                    Button("Parse living config 🌱") {
                        setupJSON(url: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/2.3.0/config.json")!)
                    } .buttonStyle(.bordered)
                }
                Spacer()
                if (config.status.isOn == false) {
                    VStack {
                        Text(config.status.title)
                        Text(config.status.message)
                        Link(config.status.linkTitle, destination: config.status.appStoreUrl)
                    }
                } else {
                    Text("Valid Config! 🎉")
                }
                Spacer()
                Spacer()

            } .navigationTitle("Parse Time!")
        }
    }
}

struct Config: Codable {
    var status: Status = Status()
    var rmsConfig: RmsConfig = RmsConfig()
}

struct Status: Codable {
    var isOn: Bool = false
    var title: String = "Defualt"
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
