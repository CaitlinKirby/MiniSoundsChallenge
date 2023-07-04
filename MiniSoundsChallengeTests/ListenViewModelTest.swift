//
//  ConfigServiceTest.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import XCTest
@testable import MiniSoundsChallenge
final class ListenViewModelTest: XCTestCase {
    
    var rmsService: StubRMSService!
    var playbackService: TestHelper.Services.StubPlaybackService!
    var listenPageViewModel: ListenPageViewModel!
    var stubDataCreation: TestHelper.Data!
    
    internal override func setUp() async throws {
        stubDataCreation = TestHelper.Data()
        rmsService = StubRMSService(
            returnStations: stubDataCreation.createStubStationsToReturn(
                data: [stubDataCreation.createStubModule(
                    data: [stubDataCreation.createStubStationData(
                        titles: stubDataCreation.createStubStationTitles(),
                        synopses: stubDataCreation.createStubStationSynopses()
                    )]
                )]
            )
        )
        playbackService = TestHelper.Services.StubPlaybackService()
        listenPageViewModel = await ListenPageViewModel(rmsLoading: rmsService, playbackService: playbackService)
    }

    func testSetupStationsDataInitsDataCorrectly() async throws {
        rmsService.returnStations =
        stubDataCreation.createStubStationsToReturn (
            data: [stubDataCreation.createStubModule (
                    data: [
                        stubDataCreation.createStubStationData (
                            titles: stubDataCreation.createStubStationTitles(),
                            synopses: stubDataCreation.createStubStationSynopses()),
                        stubDataCreation.createStubStationData (
                            titles: stubDataCreation.createStubStationTitles(),
                            synopses: stubDataCreation.createStubStationSynopses())
                            ]
                        ),
                   stubDataCreation.createStubModule(
                           data: [
                            stubDataCreation.createStubStationData(
                                titles: stubDataCreation.createStubStationTitles(),
                                synopses: stubDataCreation.createStubStationSynopses()),
                            stubDataCreation.createStubStationData(
                                titles: stubDataCreation.createStubStationTitles(),
                                synopses: stubDataCreation.createStubStationSynopses())
                           ]
                       )
                ]
            )
        try await setupData()
        await MainActor.run {
            XCTAssertEqual(listenPageViewModel.modules?.count, 2)
        }
    }
    
    
    private func setupData() async throws {
        try await listenPageViewModel.setupStationsData()
    }
    
}

class StubRMSService: RMSLoading {
    var invokedLoadData = false
    var invokedLoadDataCount = 0
    var returnStations: Stations
    
    init(invokedLoadData: Bool = false, invokedLoadDataCount: Int = 0, returnStations: Stations) {
        self.invokedLoadData = invokedLoadData
        self.invokedLoadDataCount = invokedLoadDataCount
        self.returnStations = returnStations
    }

    func loadData() async throws -> Stations {
        invokedLoadData = true
        invokedLoadDataCount += 1
        return returnStations
    }
}
