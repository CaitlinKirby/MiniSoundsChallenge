//
//  RMSLoadingService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct RMSService: RMSLoading {
    
    var config: Config
    var session = URLSession.shared

    func loadData() async throws -> Stations {
        let url = URL(string: "\(config.rmsConfig.rootUrl)\(config.rmsConfig.allStationsPath)")!
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Stations.self, from: data)
    }
}

protocol RMSLoading {
    func loadData() async throws -> Stations
}
