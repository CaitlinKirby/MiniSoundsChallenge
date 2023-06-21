//
//  StationViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 12/06/2023.
//

import Foundation

struct StationSquareViewModel {
    
    let id: String
    let title: String
    let subtitle: String
    let imageUrl: String
    
    init(id: String, title: String, subtitle: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
    
}
