//
//  StubDataCreation.swift
//  MiniSoundsChallengeTests
//
//  Created by Caitlin Kirby on 27/06/2023.
//

import Foundation

@testable import MiniSoundsChallenge
struct StubDataCreation {
    
    func createStubStationsToReturn(
        data: [Stations.Module]
    ) -> Stations {
        return Stations(
            data: data
        )
    }
    
    func createStubModule(
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
    
    func createStubStationData(
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
    
    func createStubStationTitles(
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
    
    func createStubStationSynopses(
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
