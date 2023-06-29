//
//  InvalidConfigView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/06/2023.
//

import SwiftUI

struct InvalidConfigView: View {
    
    var viewModel: InvalidConfigViewModel
    
    var body: some View {
        Text(viewModel.title)
            .font(.title)
        Text(viewModel.message)
            .font(.body)
        Link(viewModel.linkTitle, destination: viewModel.updateLink)
    }
}
