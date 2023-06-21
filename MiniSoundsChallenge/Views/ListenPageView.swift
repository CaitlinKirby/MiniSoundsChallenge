//
//  ListenPageView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/03/2023.
//

import SwiftUI

struct ListenPageView: View {
    @ObservedObject var listenPageViewModel: ListenPageViewModel
    
    var body: some View {
        VStack {
            Text("BBC Mini Sounds")
            ZStack {
                ScrollView(.vertical) {
                    ForEach(listenPageViewModel.modules ?? [], id: \.id) { module in
                        RailView(viewModel: RailViewModel(
                                title: module.title,
                                stations: module.data,
                                playbackService: listenPageViewModel.playbackService
                            )
                        )
                    }
                }
            }
        }
        .task {
            Task {
                try await listenPageViewModel.setupStationsData()
            }
            
        }
    }    
}
