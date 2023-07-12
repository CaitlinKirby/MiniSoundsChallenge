//
//  MiniSoundsChallengeApp.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI


@main
struct MiniSoundsChallengeApp: App {
    
    let configService: ConfigService
    let homeViewModel: HomeViewModel
    let viewFactory: ViewFactory
    let invalidConfigViewFactory: (Config) -> InvalidConfigView
    let listenPageViewFactory: (Config) -> ListenPageView
    
    init() {
        configService = ConfigService()
        homeViewModel = HomeViewModel(configLoading: configService)
        viewFactory = ViewFactory()
        invalidConfigViewFactory = viewFactory.invalidConfigViewFactory
        listenPageViewFactory = viewFactory.listenPageViewFactory
    }

    var body: some Scene {
        WindowGroup {
            HomeView(
                viewModel: homeViewModel,
                invalidConfigViewFactory: invalidConfigViewFactory,
                listenPageFactory: listenPageViewFactory
            )
        }
    }
}
