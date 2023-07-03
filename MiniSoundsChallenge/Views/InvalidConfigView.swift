//
//  InvalidConfigView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/06/2023.
//

import SwiftUI

struct InvalidConfigView: View {
    
    var model: InvalidConfigModel
    
    var body: some View {
        Text(model.title)
            .font(.title)
        Text(model.message)
            .font(.body)
        Link(model.linkTitle, destination: model.updateLink)
    }
}
