//
//  ViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 01/06/2023.
//

import Foundation
import UIKit
import SMP

@MainActor
class ListenPageViewModel: ObservableObject {
        
    private let rmsLoading: RMSLoading
    @Published var modules: [Stations.Module]?
    
    var smpView: UIView?
    
    var contentPlaying: Bool = false
    private var previouslyPlayingStationID: String?
    var currrentlyPlayingStationID: String? {
        didSet {
            if let currrentlyPlayingStationID {
                loadSMP(id: currrentlyPlayingStationID)
            }
        }
        willSet {
            previouslyPlayingStationID = currrentlyPlayingStationID ?? ""
        }
    }
    
    init(rmsLoading: RMSLoading) {
        self.rmsLoading = rmsLoading
    }
    
    func setupStationsData() async throws {
        modules = try await self.rmsLoading.loadData().data
    }
    
//    func getStationsCount(for moduleID: String) -> Int {
//        if let selectedModule = stations?.data.first(where: { module in
//            module.id == moduleID
//        }) {
//            return selectedModule.data.count
//        }
//        return 0
//    }
//    
//    func getModuleCount() -> Int {
//        if let stations {
//            return stations.data.count
//        }
//        return 0
//    }
    
    private func loadSMP(id: String) {
        var builder = BBCSMPPlayerBuilder()
        builder = builder.withInterruptionEndedBehaviour(.autoresume)
        let smp = builder.build()
                 
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
        
        let viewController = smp.buildUserInterface().buildViewController()
        let itemProvider = playerItemProvider.withVideoTrackSubscriber(smp.buildUserInterface().buildViewController()).buildItemProvider()
         
        smp.playerItemProvider = itemProvider
        smpView = viewController.view
        if contentPlaying && previouslyPlayingStationID == currrentlyPlayingStationID {
            smp.pause()
        } else {
            smp.play()
        }
        
    }
}
