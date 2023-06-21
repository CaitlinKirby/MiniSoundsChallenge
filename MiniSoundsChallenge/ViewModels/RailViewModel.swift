//
//  RailViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 20/06/2023.
//

import Foundation

class RailViewModel: ObservableObject {
    var title: String
    @Published var stations: [Stations.Module.StationData]
    
    init(title: String, stations: [Stations.Module.StationData]) {
        self.title = title
        self.stations = stations
    }
    
}
