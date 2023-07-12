//
//  NetworkRepository.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 06/07/2023.
//

import Foundation

struct NetworkRepository<Model: Decodable> {
    
    private var session = URLSession.shared
    
    func loadFromNetwork(url: URL) async throws -> Model {
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Model.self, from: data)
    }
    
}

//protocol NetworkLoading {
//    func loadFromNetwork(url: URL) -> Model
//}
