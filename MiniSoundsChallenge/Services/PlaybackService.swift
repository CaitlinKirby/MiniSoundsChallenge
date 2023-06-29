//
//  PlaybackService.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 16/06/2023.
//

import Foundation
import UIKit
import SMP

class PlaybackService {
    
    private var smpView: UIView?
    private var smp: BBCSMP
    
    var contentPlaying: Bool = false
    var currrentlyLoadedStationID: String?
    
    init() {
        func buildSMP() -> BBCSMP {
            var builder = BBCSMPPlayerBuilder()
            builder = builder.withInterruptionEndedBehaviour(.autoresume)
            return builder.build()
        }
        smp = buildSMP()
    }
    
    func play(_ stationID: String) {
        if currrentlyLoadedStationID != stationID {
            loadSMP(id: stationID)
        }
        smp.play()
        currrentlyLoadedStationID = stationID
        contentPlaying = true
    }
    
    func pause() {
        smp.pause()
        contentPlaying = false
    }
    
    private func loadSMP(id: String) {
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
        
        let viewController = smp.buildUserInterface().buildViewController()
        let itemProvider = playerItemProvider.withVideoTrackSubscriber(smp.buildUserInterface().buildViewController()).buildItemProvider()
         
        smp.playerItemProvider = itemProvider
        smpView = viewController.view
    }
}
