//
//  PlaybackRepository.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 03/07/2023.
//

import Foundation
import SMP

protocol PlaybackRepository {
    func play(_ id: String)
    func pause()
}

class PlaybackSMP: PlaybackRepository {
    private var smp: BBCSMP
    private var smpView: UIView?
    private var currentlyLoadedID: String?
    
    init() {
        func buildSMP() -> BBCSMP {
            var builder = BBCSMPPlayerBuilder()
            builder = builder.withInterruptionEndedBehaviour(.autoresume)
            return builder.build()
        }
        smp = buildSMP()
    }
    
    func play(_ id: String) {
        if id != currentlyLoadedID {
            loadSMP(id: id)
            currentlyLoadedID = id
        }
        smp.play()
    }
    
    func pause() {
        smp.pause()
    }
    
    private func loadSMP(id: String) {
        let playerItemProvider = MediaSelectorItemProviderBuilder(VPID: id, mediaSet: "mobile-phone-main", AVType: .audio, streamType: .simulcast, avStatisticsConsumer: MyAvStatisticsConsumer())
        
        let viewController = smp.buildUserInterface().buildViewController()
        let itemProvider = playerItemProvider.withVideoTrackSubscriber(smp.buildUserInterface().buildViewController()).buildItemProvider()
         
        smp.playerItemProvider = itemProvider
        smpView = viewController.view
    }
    
}
