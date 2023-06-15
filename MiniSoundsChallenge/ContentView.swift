//
//  ContentView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

//TODO: Rename File to HomeView
import SwiftUI

//TODO: Create HomeView with a ConfigLoadingViewModel and ListenPageFactory()
struct HomeView: View {
    
    viewModel
    var body: some View {
        //TODO: Use Buttons instead and fire an action on ConfigLoadingViewModel called loadConfig(url: YourURL for each button here)
        //TODO: Create an if here, if viewModel.configLoaded then show your listenPageFactory() if not show your buttons or an error message
        //TODO: Your config view model should talk to the network and load the config then update the viewModel's published configLoaded property
        //TODO: You should then be able to remove setupConfigJSON from your ListenPageViewModel
        NavigationView {
            VStack {
                 NavigationLink(destination: ListenPageView(listenPageViewModel: ListenPageViewModel(configUrl: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/1.15.0/config.json")!))) {
                     Text("Parse killed config")
                 }
                 .background(.red)
                NavigationLink(destination: ListenPageView(listenPageViewModel: ListenPageViewModel(configUrl: URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/2.3.0/config.json")!))) {
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

//TODO: Move to it's own file and Data Access Folder
struct Config: Codable {
    //TODO: You shouldn't have to new these up in your model objects, you need to create ListenPageViewModel with this already loaded from the network rather than doing the loading in the view model
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

//TODO: Move to it's own file and Data Access Folder
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
