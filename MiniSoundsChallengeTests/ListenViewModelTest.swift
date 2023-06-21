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
    var listenPageViewModel: ListenPageViewModel!
    
    internal override func setUp() async throws {
        rmsService = StubRMSService(
            returnStations: createStubStationsToReturn(
                data: [createStubModule(
                    data: [createStubStationData(
                        titles: createStubStationTitles(),
                        synopses: createStubStationSynopses()
                    )]
                )]
            )
        )
        listenPageViewModel = await ListenPageViewModel(rmsLoading: rmsService)
    }

    func testSetupStationsDataInitsDataCorrectly() async throws {
        rmsService.returnStations =
            createStubStationsToReturn (
                data: [createStubModule (
                    data: [
                        createStubStationData (
                            titles: createStubStationTitles(),
                            synopses: createStubStationSynopses()),
                        createStubStationData (
                            titles: createStubStationTitles(),
                            synopses: createStubStationSynopses())
                            ]
                        ),
                       createStubModule(
                           data: [
                               createStubStationData(
                                   titles: createStubStationTitles(),
                                   synopses: createStubStationSynopses()),
                               createStubStationData(
                                   titles: createStubStationTitles(),
                                   synopses: createStubStationSynopses())
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
    
    private func createStubStationsToReturn(
        data: [Stations.Module]
    ) -> Stations {
        return Stations(
            data: data
        )
    }
    
    private func createStubModule(
        title: String = "",
        data: [Stations.Module.StationData],
        id: String = ""
    ) -> Stations.Module {
        return Stations.Module(
            title: title,
            data: data,
            id: id
        )
    }
    
    private func createStubStationData(
        id: String = "",
        titles: Stations.Module.StationData.Titles,
        synopses: Stations.Module.StationData.Synopses,
        image_url: String = ""
    ) -> Stations.Module.StationData {
        return Stations.Module.StationData(
            id: id,
            titles: titles,
            synopses: synopses,
            image_url: image_url
        )
    }
    
    private func createStubStationTitles(
        primary: String = "",
        secondary: String = "",
        tertiary: String = ""
    ) -> Stations.Module.StationData.Titles {
        return Stations.Module.StationData.Titles(
            primary: primary,
            secondary: secondary,
            tertiary: tertiary
        )
    }
    
    private func createStubStationSynopses(
        short: String = "",
        medium: String = "",
        long: String = ""
    ) -> Stations.Module.StationData.Synopses {
        return Stations.Module.StationData.Synopses(
            short: short,
            medium: medium,
            long: long
        )
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
