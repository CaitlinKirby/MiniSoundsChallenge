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
    var playbackRepository: PlaybackRepository!
    
    override func setUp() async throws {
        playbackRepository = TestHelper.Repositories.StubPlaybackRepository()
        playbackService = PlaybackService(playbackRepository: playbackRepository)
    }
    
    func testPlay() {
        let stationID = "testID"
        playbackService.playOrPause(stationID)
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, stationID)
        XCTAssertTrue(playbackService.contentPlaying)
    }
    
    func testPause() {
        let stationID = "testID"
        playbackService.playOrPause(stationID)
        playbackService.playOrPause(stationID)
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, stationID)
        XCTAssertFalse(playbackService.contentPlaying)
    }
    
    func testPlayOneItemThenPlayADifferentItem() {
        let firstID = "firstStationID"
        let secondID = "secondStationID"
        playbackService.playOrPause(firstID)
        playbackService.playOrPause(secondID)
        XCTAssertEqual(playbackService.currrentlyLoadedStationID, secondID)
        XCTAssertTrue(playbackService.contentPlaying)
    }
    
}
