//
//  ContentView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        switch viewModel.configResultState {
        case .valid(let config):
            ListenPageView(listenPageViewModel: ListenPageViewModel(rmsLoading: RMSService(config: config), playbackService: PlaybackService()))
        case .invalid:
            Text("Invalid")
        case .unsuccessful:
            Text("Wow we reached here when we sholn'dt have")
        case .notLoaded:
            Button("Valid") {
                Task {
                    await viewModel.buttonTapped(isValid: true)
                }
            }
            Button("Invalid") {
                Task {
                    await viewModel.buttonTapped(isValid: false)
                }
            }
        }

        
    }
    
}
