//
//  RailViewModelTests.swift
//  MiniSoundsChallengeTests
//
//  Created by Caitlin Kirby on 27/06/2023.
//

import Foundation

import XCTest
@testable import MiniSoundsChallenge
final class RailViewModelTests: XCTestCase {
    
    var playbackService: StubPlaybackService!
    var viewModel: RailViewModel!
    var stubDataCreation: StubDataCreation!
    
    override func setUp() async throws {
        playbackService = StubPlaybackService()
        stubDataCreation = StubDataCreation()
        viewModel = RailViewModel(
            title: "",
            stations: [stubDataCreation.createStubStationData(
                titles: stubDataCreation.createStubStationTitles(),
                synopses: stubDataCreation.createStubStationSynopses())],
            playbackService: playbackService)
    }
    
    func testTapOncePlaysContent() {
        let stationID = "stationID"
        viewModel.tapped(stationID: stationID)
        XCTAssertTrue(playbackService.calledPlay)
    }
    
    func testTapTwiceOnSameStationPausesContent() {
        let stationID = "stationID"
        viewModel.tapped(stationID: stationID)
        viewModel.tapped(stationID: stationID)
        XCTAssertTrue(playbackService.calledPause)
    }
    
    func testTapTwiceOnDifferentStationPausesContent() {
        let stationID1 = "stationID1"
        let stationID2 = "stationID2"
        viewModel.tapped(stationID: stationID1)
        viewModel.tapped(stationID: stationID2)
        XCTAssertTrue(playbackService.calledPlay)
        XCTAssertFalse(playbackService.calledPause)
    }
}

class StubPlaybackService: PlaybackService {
    var calledPlay = false
    override func play(_ stationID: String) {
        currrentlyLoadedStationID = stationID
        contentPlaying = true
        calledPlay = true
    }
    
    var calledPause = false
    override func pause() {
        contentPlaying = false
        calledPause = true
    }
}
