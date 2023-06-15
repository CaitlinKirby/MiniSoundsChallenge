//
//  MiniSoundsChallengeApp.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import SwiftUI

@main
struct MiniSoundsChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let configService = ConfigService()
            let homeViewModel = HomeViewModel(configLoading: configService)
            HomeView(viewModel: homeViewModel)
        }
    }
}
