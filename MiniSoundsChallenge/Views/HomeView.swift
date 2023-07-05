//
//  ContentView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    let invalidConfigViewFactory: (Config) -> InvalidConfigView
    let listenPageFactory: (Config) -> ListenPageView
    
    init(viewModel: HomeViewModel, invalidConfigViewFactory: @escaping (Config) -> InvalidConfigView, listenPageFactory: @escaping (Config) -> ListenPageView) {
        self.viewModel = viewModel
        self.invalidConfigViewFactory = invalidConfigViewFactory
        self.listenPageFactory = listenPageFactory
    }

    var body: some View {
        switch viewModel.configResultState {
        case .valid(let config):
            listenPageFactory(config)
        case .invalid(let config):
            invalidConfigViewFactory(config)
        case .unsuccessful:
            Text("Unsuccessful Load")
        case .notLoaded:
            ValidButton()
            InvalidButton()
        }
    }
    
    @ViewBuilder
    private func ValidButton() -> some View {
        Button("Valid") {
            Task {
                await viewModel.buttonTapped(isValid: true)
            }
        }.modifier(ButtonStyle(backgroundColour: .green))
    }
    
    @ViewBuilder
    private func InvalidButton() -> some View {
        Button("Invalid") {
            Task {
                await viewModel.buttonTapped(isValid: false)
            }
        }.modifier(ButtonStyle(backgroundColour: .red))
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
