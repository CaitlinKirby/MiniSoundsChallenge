//
//  HomeViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 15/06/2023.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    enum ConfigResultState: Equatable {
        static func == (lhs: HomeViewModel.ConfigResultState, rhs: HomeViewModel.ConfigResultState) -> Bool {
            switch (lhs, rhs) {
            case (.valid, .valid), (.invalid, .invalid), (.unsuccessful, .unsuccessful), (.notLoaded, .notLoaded):
                return true
            default:
                return false
            }
        }
        
        case valid(Config)
        case invalid(Config)
        case unsuccessful
        case notLoaded
    }
    
    private let invalidURL = URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/1.15.0/config.json")!
    private let validURL = URL(string: "https://sounds-mobile-config.files.bbci.co.uk/ios/2.3.0/config.json")!
    private let configLoading: ConfigLoading
    
    @Published var configResultState: ConfigResultState
    
    init(configLoading: ConfigLoading) {
        self.configLoading = configLoading
        self.configResultState = .notLoaded
    }
    
    func buttonTapped(isValid: Bool) async {
        do {
            let result = try await configLoading.loadConfig(url: isValid ? validURL : invalidURL)
            configResultState = result.status.isOn ? ConfigResultState.valid(result) : ConfigResultState.invalid(result)
        } catch {
            configResultState = ConfigResultState.unsuccessful
        }
    }
    
}
