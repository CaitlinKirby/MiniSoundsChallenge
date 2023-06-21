//
//  ViewModel.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 01/06/2023.
//

import Foundation
import UIKit
import SwiftUI

@MainActor
class ListenPageViewModel: ObservableObject {
    
    @Published var modules: [Stations.Module]?

    private let rmsLoading: RMSLoading
    let playbackService: PlaybackService
    @State var smpVideoView: UIView?
    
    init(rmsLoading: RMSLoading, playbackService: PlaybackService) {
        self.rmsLoading = rmsLoading
        self.playbackService = playbackService
    }
    
    func setupStationsData() async throws {
        modules = try await self.rmsLoading.loadData().data
    }
    
}
