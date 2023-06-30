//
//  ConfigService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

struct ConfigService: ConfigLoading {
    
    private var session = URLSession.shared

    func loadConfig(url: URL) async throws -> Config {
        //TODO - You could make this a generic repo so you just pass the url and model you want to a NetworkRepository and that handles the data access
        // This allows you to move away from URLSession if you need to and it will remove the duplicated code you have in RMSService
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Config.self, from: data)
    }
}

protocol ConfigLoading {
    func loadConfig(url: URL) async throws -> Config
}
