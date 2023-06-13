//
//  ListenPageView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/03/2023.
//

import SwiftUI

struct ListenPageView: View {
    
    @ObservedObject var listenPageViewModel: ListenPageViewModel
    @State var smpVideoView: UIView?
    
    struct UpdateWarning: View {
        let title: String
        let message: String
        let linkTitle: String
        let appStoreUrl: URL
        
        var body: some View {
            VStack {
                Text(title)
                Text(message)
                Link(linkTitle, destination: appStoreUrl).foregroundColor(.blue)
            } .accessibilityElement(children: .combine)
                .accessibilityLabel(Text("\(title)  \(message) \(linkTitle)"))
                .padding(10)
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
        }
    }
    
    struct Rail: View {
        let stationGroup: Stations.Module
        let listenPageViewModel: ListenPageViewModel
        
        var body: some View {
            VStack {
                Text(stationGroup.title)
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(stationGroup.data, id: \.id) { station in
                            StationSquareView(viewModel: StationSquareViewModel(
                                id: station.id,
                                title: station.titles.primary,
                                subtitle: station.synopses.short,
                                imageUrl: station.imageUrl))
                                .onTapGesture {
                                    listenPageViewModel.contentPlaying.toggle()
                                    listenPageViewModel.currrentlyPlayingStationID = station.id
                                }
                            
                        } .padding(.trailing, 20)
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Group {
                        if(listenPageViewModel.stations.data.count > 0) {
                            ScrollView(.vertical) {
                                ForEach(listenPageViewModel.stations.data, id: \.id) { stationGroup in
                                    Rail(stationGroup: stationGroup, listenPageViewModel: listenPageViewModel)
                                }
                            }
                        }
                    } .accessibilityHidden(listenPageViewModel.config.status.isOn ? false : true)
                    Group {
                        if(listenPageViewModel.config.status.isOn == false) {
                            UpdateWarning(
                                title: listenPageViewModel.config.status.title,
                                message: listenPageViewModel.config.status.message,
                                linkTitle: listenPageViewModel.config.status.linkTitle,
                                appStoreUrl: listenPageViewModel.config.status.appStoreUrl
                            )
                        }
                    }
                }
            }
            .navigationTitle("BBC Mini Sounds")
            .onAppear {
                Task {
                    await listenPageViewModel.setupConfigJSON()
                }
            }
        }
    }
    
}
