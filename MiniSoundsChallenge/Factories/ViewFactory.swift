//
//  ViewFactory.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 05/07/2023.
//

import Foundation

struct ViewFactory {
    func invalidConfigViewFactory(config: Config) -> InvalidConfigView {
        let model = InvalidConfigModel(
            title: config.status.title,
            message: config.status.message,
            linkTitle: config.status.linkTitle,
            updateLink: config.status.appStoreUrl)
        return InvalidConfigView(model: model)
    }
    @MainActor
    func listenPageViewFactory(config: Config) -> ListenPageView {
        let url = URL(string: "\(config.rmsConfig.rootUrl)\(config.rmsConfig.allStationsPath)")!
        let rmsLoading = RMSService(url: url)
        let playbackService = PlaybackService(playbackRepository: PlaybackSMP())
        let viewModel = ListenPageViewModel(rmsLoading: rmsLoading, playbackService: playbackService)
        return ListenPageView(listenPageViewModel: viewModel)
    }
}
