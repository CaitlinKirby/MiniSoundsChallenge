//
//  InvalidConfigViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/06/2023.
//

import Foundation

struct InvalidConfigViewModel {
    let title: String
    let message: String
    let linkTitle: String
    let updateLink: URL
    
    init(title: String, message: String, linkTitle: String, updateLink: URL) {
        self.title = title
        self.message = message
        self.linkTitle = linkTitle
        self.updateLink = updateLink
    }
}
