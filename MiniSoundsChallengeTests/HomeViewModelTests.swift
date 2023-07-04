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
        configService = StubConfigService(config: createConfigToReturn())
        homeViewModel = await HomeViewModel(configLoading: configService)
    }
    
    func testWhenConfigButtonTappedLoadConfigCalled() async {
        await homeViewModel.buttonTapped(isValid: true)
        
        XCTAssertTrue(configService.loadConfigWasCalled)
    }
    
    func testConfigResultStateIsNotLoadedOnInit() async {
        let resultConfigResultState = await homeViewModel.configResultState
        XCTAssertEqual(resultConfigResultState, .notLoaded)
    }
    
    func testValidConfigSetsValidEnumState() async {
        configService.configToReturn = createConfigToReturn(isOn: true)
                
        await homeViewModel.buttonTapped(isValid: true)

        let resultConfigResultState = await homeViewModel.configResultState
        XCTAssertEqual(resultConfigResultState, .valid(configService.configToReturn))
    }
    
    func testInvalidConfigSetsInvalidEnumState() async {
        configService.configToReturn = createConfigToReturn(isOn: false)
        
        await homeViewModel.buttonTapped(isValid: false)

        let resultConfigResultState = await homeViewModel.configResultState
        XCTAssertEqual(resultConfigResultState, .invalid(configService.configToReturn))
    }
    
    private func createConfigToReturn(
        isOn: Bool = false,
        title: String = "",
        message: String = "",
        linkTitle: String = "",
        appStoreUrl: URL = URL(string: "www.bbc.co.uk")!,
        apiKey: String = "",
        rootUrl: URL = URL(string: "www.bbc.co.uk")!,
        allStationsPath: String = "") -> Config
    {
        return Config(
            status: Config.Status(
                isOn: isOn,
                title: title,
                message: message,
                linkTitle: linkTitle,
                appStoreUrl: appStoreUrl),
            rmsConfig: Config.RmsConfig(
                apiKey: apiKey,
                rootUrl: rootUrl,
                allStationsPath: allStationsPath)
        )
    }
}

class StubConfigService: ConfigLoading {
    
    var configToReturn: Config
    
    init(config: Config) {
        configToReturn = config
    }
    
    var loadConfigWasCalled = false
    func loadConfig(url: URL) async -> Config {
        loadConfigWasCalled = true
        return configToReturn
    }
    
}
