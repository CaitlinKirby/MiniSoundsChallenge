//
//  ListenPageView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/03/2023.
//

import SwiftUI

struct ListenPageView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var smpVideoView: UIView?
    
    struct RadioIcon: View {
        var station: Stations.Module.StationData
        
        var body: some View {
            ZStack {
                AsyncImage(
                    url: URL(string: station.imageUrl.replacingOccurrences(of: "{recipe}", with: "320x320")),
                    content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }, placeholder: {} )
                    .clipShape(Circle())
                    .frame(maxWidth: 150, maxHeight: 150)
                Circle()
                    .strokeBorder(.orange, lineWidth: 3)
                    .frame(width: 150, height: 150)
            } .padding(.leading, 10)
        }
    }
    
    
    struct StationSquare: View {
        var station: Stations.Module.StationData
        var tapped: () -> Void
        
        var body: some View {
            VStack {
                RadioIcon(station: station)
                Text(station.titles.primary)
                    .font(.title3)
                    .frame(maxWidth: 150, minHeight: 50, maxHeight: 75)
                    .multilineTextAlignment(.center)
                Text(station.synopses.short)
                    .font(.system(size:15))
                    .frame(maxWidth: 150, minHeight: 50)
                    .padding(.bottom, 20)
            }.accessibilityLabel(Text("\(station.titles.primary).  \(station.synopses.short)"))
                .onTapGesture {
                    tapped()
                }
        }
    }
    
    struct RailHeading: View {
        var text: String
        
        var body: some View {
            Text(text)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
        }
    }
    
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
                SMPView(smpVideoView: smpVideoView)
                ZStack {
                    Group {
                        if(viewModel.stations.data.count > 0) {
                            
                            ScrollView(.vertical) {
                                ForEach(viewModel.stations.data, id: \.id) { stationGroup in
                                    VStack {
                                        RailHeading(text: stationGroup.title)
                                        ScrollView(.horizontal) {
                                            HStack {
                                                ForEach(stationGroup.data, id: \.id) { station in
                                                    StationSquare(station: station) {
                                                        viewModel.loadSMP(id: station.id)
                                                        smpVideoView = viewModel.smpView
                                                    }
                                                } .padding(.trailing, 20)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } .accessibilityHidden(viewModel.config.status.isOn ? false : true)
                    Group {
                        if(viewModel.config.status.isOn == false) {
                            UpdateWarning(
                                title: viewModel.config.status.title,
                                message: viewModel.config.status.message,
                                linkTitle: viewModel.config.status.linkTitle,
                                appStoreUrl: viewModel.config.status.appStoreUrl
                            )
                        }
                    }
                }
            }
            .navigationTitle("BBC Mini Sounds")
            .onAppear {
                Task {
                    await viewModel.setupConfigJSON()
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
