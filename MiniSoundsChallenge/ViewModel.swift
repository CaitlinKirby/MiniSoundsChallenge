//
//  ViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 01/06/2023.
//

import Foundation
import UIKit
import SMP

class ViewModel: ObservableObject {
    
    private let configUrl: URL
    @Published var config: Config
    @Published var stations: Stations
    var smpView: UIView?
    
    init(configUrl: URL) {
        self.configUrl = configUrl
        self.config = Config()
        self.stations = Stations()
    }
    
    func loadSMP(id: String) {
        var builder = BBCSMPPlayerBuilder()
        builder = builder.withInterruptionEndedBehaviour(.autoresume)
        let smp = builder.build()
        
        print(id)
         
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
        
        let viewController = smp.buildUserInterface().buildViewController()
        let itemProvider = playerItemProvider.withVideoTrackSubscriber(smp.buildUserInterface().buildViewController()).buildItemProvider()
         
        smp.playerItemProvider = itemProvider
        smpView = viewController.view
    }
    
    func setupConfigJSON() async {
        let task = URLSession.shared.dataTask(with: configUrl) { [self] data, response, error in
            DispatchQueue.main.sync {
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(Config.self, from: data)
                        config = decoded
                        self.setupDataJSON(url: URL(string: "\(config.rmsConfig.rootUrl)\(config.rmsConfig.allStationsPath)")!)
                    } catch {
                        print("Failed to decode Config JSON")
                    }
                }
                else if let error = error {
                    print("Request failed: \(error)")
                }
            }
        }
        task.resume()
    }
    
    private func setupDataJSON(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.sync {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let decoded = try decoder.decode(Stations.self, from: data)
                        self.stations = decoded
                    } catch {
                        print("Failed to decode Data JSON")
                    }
                }
                else if let error = error {
                    print("Request failed: \(error)")
                }
            }
        }
        task.resume()
    }
}
