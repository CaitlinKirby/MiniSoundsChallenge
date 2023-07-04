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
    
    private var playbackRepository: PlaybackRepository
    var contentPlaying: Bool = false
    var currrentlyLoadedStationID: String?    
    
    init(playbackRepository: PlaybackRepository) {
        self.playbackRepository = playbackRepository
    }
    
    func playOrPause(_ id: String) {
        if contentPlaying && currrentlyLoadedStationID == id {
            playbackRepository.pause()
            contentPlaying = false
        } else {
            playbackRepository.play(id)
            currrentlyLoadedStationID = id
            contentPlaying = true
        }
    }
}
