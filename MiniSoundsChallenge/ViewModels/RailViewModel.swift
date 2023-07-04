//
//  RailViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 20/06/2023.
//

import Foundation

class RailViewModel: ObservableObject {
    let playbackService: PlaybackService
    var title: String
    @Published var stations: [Stations.Module.StationData]
    
    init(title: String, stations: [Stations.Module.StationData], playbackService: PlaybackService) {
        self.title = title
        self.stations = stations
        self.playbackService = playbackService
    }
    
    func tapped(stationID: String) {
        playbackService.playOrPause(stationID)
    }
    
}
