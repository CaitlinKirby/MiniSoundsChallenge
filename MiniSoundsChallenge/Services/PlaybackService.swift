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
