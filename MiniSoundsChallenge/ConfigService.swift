//
//  ConfigService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct ConfigService: ConfigLoading {
    
    var session = URLSession.shared

    func loadConfig(url: URL) async throws -> Config {
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Config.self, from: data)
    }
    
    
    
}

protocol ConfigLoading {
    func loadConfig(url: URL) async throws -> Config
}
