//
//  ConfigLoadingService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation

protocol ConfigProviding {
    func getConfig()
    
}

struct ConfigLoadingService: ConfigProviding {
    func getConfig(url:) {
        repository.getConfig { <#Config#> in
            <#code#>
        }
    }
    
    
    private let repository: ConfigLoadingRepository
    
    init(repository: ConfigLoadingRepository) {
        self.repository = repository
    }
    
}

protocol ConfigLoadingRepository {
    func getConfig(completion: (Config) -> Void)
}

struct NetworkConfigLoadingRepository: ConfigLoadingRepository {
    func getConfig(completion: (Result<Config, Error>) -> Void) {
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
}

