//
//  RMSLoadingService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct RMSService: RMSLoading {

    let networkRepository: NetworkRepository<Stations>
    let url: URL
    
    init(url: URL) {
        networkRepository = NetworkRepository<Stations>()
        self.url = url
    }
    
    func loadData() async throws -> Stations {
        try await networkRepository.loadFromNetwork(url: url)
    }
}

protocol RMSLoading {
    func loadData() async throws -> Stations
}
