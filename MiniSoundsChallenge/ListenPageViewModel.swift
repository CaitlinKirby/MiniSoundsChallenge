//
//  ViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 01/06/2023.
//

import Foundation
import UIKit
import SMP

class ListenPageViewModel: ObservableObject {
        
    let config: Config
    @Published var stations: Stations
    var smpView: UIView?
    
    var contentPlaying: Bool = false
    private var previouslyPlayingStationID: String?
    var currrentlyPlayingStationID: String? {
        didSet {
            if let currrentlyPlayingStationID {
                loadSMP(id: currrentlyPlayingStationID)
            }
        }
        willSet {
            previouslyPlayingStationID = currrentlyPlayingStationID ?? ""
        }
    }
    
    init(config: Config) {
        self.config = config
        self.stations = Stations()
        setupDataJSON(url: URL(string: "\(config.rmsConfig.rootUrl)\(config.rmsConfig.allStationsPath)")!)
    }
    
    private func loadSMP(id: String) {
        var builder = BBCSMPPlayerBuilder()
        builder = builder.withInterruptionEndedBehaviour(.autoresume)
        let smp = builder.build()
                 
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
        
        let viewController = smp.buildUserInterface().buildViewController()
        let itemProvider = playerItemProvider.withVideoTrackSubscriber(smp.buildUserInterface().buildViewController()).buildItemProvider()
         
        smp.playerItemProvider = itemProvider
        smpView = viewController.view
        if contentPlaying && previouslyPlayingStationID == currrentlyPlayingStationID {
            smp.pause()
        } else {
            smp.play()
        }
        
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
