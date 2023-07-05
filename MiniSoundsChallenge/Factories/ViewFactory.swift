//
//  ViewFactory.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 05/07/2023.
//

import Foundation

@MainActor
struct ViewFactory {
    func invalidConfigViewFactory(config: Config) -> InvalidConfigView {
        let model = InvalidConfigModel(
            title: config.status.title,
            message: config.status.message,
            linkTitle: config.status.linkTitle,
            updateLink: config.status.appStoreUrl)
        return InvalidConfigView(model: model)
    }
    func listenPageViewFactory(config: Config) -> ListenPageView {
        let rmsLoading = RMSService(config: config)
        let playbackService = PlaybackService(playbackRepository: PlaybackSMP())
        let viewModel = ListenPageViewModel(rmsLoading: rmsLoading, playbackService: playbackService)
        return ListenPageView(listenPageViewModel: viewModel)
    }
}
