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
        case .invalid(let config):
            InvalidConfigView(viewModel: InvalidConfigViewModel(
                title: config.status.title,
                message: config.status.message,
                linkTitle: config.status.linkTitle,
                updateLink: config.status.appStoreUrl)
            )
        case .unsuccessful:
            Text("Wow we reached here when we sholn'dt have")
        case .notLoaded:
            Button("Valid") {
                Task {
                    await viewModel.buttonTapped(isValid: true)
                }
            }.modifier(ButtonStyle(backgroundColour: .green))
            Button("Invalid") {
                Task {
                    await viewModel.buttonTapped(isValid: false)
                }
            }.modifier(ButtonStyle(backgroundColour: .red))
        }

        
    }
    
    struct ButtonStyle: ViewModifier {
        var backgroundColour: Color
        func body(content: Content) -> some View {
            content
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColour)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}
