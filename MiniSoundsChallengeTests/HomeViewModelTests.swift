//
//  MiniSoundsChallengeTests.swift
//  MiniSoundsChallengeTests
//
//  Created by Caitlin Kirby on 07/03/2023.
//

import XCTest
@testable import MiniSoundsChallenge

final class HomeViewModelTests: XCTestCase {
    
    var configService: StubConfigService!
    var homeViewModel: HomeViewModel!
    
    internal override func setUp() async throws {
        configService = StubConfigService()
        homeViewModel = HomeViewModel(configLoading: configService)
    }
    
    func testWhenConfigButtonTappedLoadConfigCalled() async {
        await homeViewModel.buttonTapped(isValid: true)
        
        XCTAssertTrue(configService.loadConfigWasCalled)
    }
    
    func testConfigResultStateIsNotLoadedOnInit() async {
        XCTAssertEqual(homeViewModel.configResultState, .notLoaded)
    }
    
    func testValidConfigSetsValidEnumState() async {
        let validTestConfig = Config(status: Config.Status(isOn: true))
        configService.configToReturn = validTestConfig
                
        await homeViewModel.buttonTapped(isValid: true)

        XCTAssertEqual(homeViewModel.configResultState, .valid)
    }
    
    func testInvalidConfigSetsInvalidEnumState() async {
        let invalidTestConfig = Config(status: Config.Status(isOn: false))
        configService.configToReturn = invalidTestConfig
                
        await homeViewModel.buttonTapped(isValid: false)

        XCTAssertEqual(homeViewModel.configResultState, .invalid)
    }
    
}

class StubConfigService: ConfigLoading {
    
    var configToReturn = Config()
    
    var loadConfigWasCalled = false
    func loadConfig(url: URL) async -> Config {
        loadConfigWasCalled = true
        return configToReturn
    }
    
}
