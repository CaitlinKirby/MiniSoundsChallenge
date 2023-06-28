//
//  PlayableServiceTests.swift
//  MiniSoundsChallengeTests
//
//  Created by Caitlin Kirby on 27/06/2023.
//

import Foundation

import XCTest
@testable import MiniSoundsChallenge
final class PlaybackServiceTests: XCTestCase {
    
    var playbackService: PlaybackService!
    
    override func setUp() async throws {
        playbackService = PlaybackService()
    }
    
    func testPlay() {
        let stationID = "testID"
        playbackService.play(stationID)
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, stationID)
        XCTAssertTrue(playbackService.contentPlaying)
    }
    
    func testPause() {
        let stationID = "testID"
        playbackService.play(stationID)
        playbackService.pause()
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, stationID)
        XCTAssertFalse(playbackService.contentPlaying)
    }
    
    func testPlayOneItemThenPlayADifferentItem() {
        let firstID = "firstStationID"
        let secondID = "secondStationID"
        playbackService.play(firstID)
        playbackService.play(secondID)
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, secondID)
        XCTAssertTrue(playbackService.contentPlaying)
    }
    
}
