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
    
    var playbackService: TestHelper.Services.StubPlaybackService!
    var viewModel: RailViewModel!
    var stubDataCreation: TestHelper.Data!
    
    override func setUp() async throws {
        playbackService = TestHelper.Services.StubPlaybackService()
        stubDataCreation = TestHelper.Data()
        viewModel = RailViewModel(
            title: "",
            stations: [stubDataCreation.createStubStationData(
                titles: stubDataCreation.createStubStationTitles(),
                synopses: stubDataCreation.createStubStationSynopses())],
            playbackService: playbackService)
    }
    
    func testTapOnceCallsPlayOrPauseOnPlaybackService() {
        let stationID = "stationID"
        viewModel.tapped(stationID: stationID)
        XCTAssertTrue(playbackService.calledPlayOrPause)
    }
}
