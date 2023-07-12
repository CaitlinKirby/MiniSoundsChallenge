//
//  ConfigService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct ConfigService: ConfigLoading {
    
    let networkRepository: NetworkRepository<Config>
    
    init() {
        networkRepository = NetworkRepository<Config>()
    }
    
    func loadConfig(url: URL) async throws -> Config {
        try await networkRepository.loadFromNetwork(url: url)
    }
}

protocol ConfigLoading {
    func loadConfig(url: URL) async throws -> Config
}
