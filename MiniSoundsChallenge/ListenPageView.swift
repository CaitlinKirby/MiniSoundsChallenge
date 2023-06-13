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
    
    var body: some View {
        NavigationView {
            VStack {
                // SMPView(smpVideoView: smpVideoView)
                ZStack {
                    Group {
                        if(listenPageViewModel.stations.data.count > 0) {
                            ScrollView(.vertical) {
                                ForEach(listenPageViewModel.stations.data, id: \.id) { stationGroup in
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
                                                            listenPageViewModel.currrentlyPlayingStationID = station.id
                                                            // listenPageViewModel.loadSMP(id: station.id)
                                                            smpVideoView = listenPageViewModel.smpView
                                                        }
                                                    
                                                } .padding(.trailing, 20)
                                            }
                                        }
                                    }
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

class SMPUIView: UIView {

    var videoView: UIView? {
        didSet {
            updateVideoView(oldVideoView: oldValue)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    convenience init(videoView: UIView?) {
        self.init(frame: .zero)
        self.videoView = videoView
    }

    private func setupView() {
        updateVideoView(oldVideoView: nil)
    }

    private func updateVideoView(oldVideoView: UIView?) {
        oldVideoView?.removeFromSuperview()
        guard let videoView = videoView else { return }
        videoView.frame = self.bounds
        self.addSubview(videoView)
    }
}

struct SMPView: UIViewRepresentable {

    var smpVideoView: UIView?

    func makeUIView(context: Context) -> UIView {
        return SMPUIView(videoView: smpVideoView)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let uiView = uiView as? SMPUIView else { return }
        uiView.videoView = smpVideoView
    }
}
