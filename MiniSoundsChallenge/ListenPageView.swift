//
//  ListenPageView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 28/03/2023.
//

import SwiftUI

struct ListenPageView: View {
    let configUrl: URL
    @State private var config = Config()
    @State private var stations = Stations()
    
    func setupConfigJSON() {
        let task = URLSession.shared.dataTask(with: configUrl) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(Config.self, from: data)
                    config = decoded
                    setupDataJSON(url: URL(string: "\(config.rmsConfig.rootUrl)\(config.rmsConfig.allStationsPath)")!)
                } catch {
                    print("Failed to decode Config JSON")
                }
            }
            else if let error = error {
                print("Request failed: \(error)")
            }
        }
        task.resume()
    }
    func setupDataJSON(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let decoded = try decoder.decode(Stations.self, from: data)
                    stations = decoded
                } catch {
                    print("Failed to decode Data JSON")
                }
            }
            else if let error = error {
                print("Request failed: \(error)")
            }
        }
        task.resume()
    }
    
    
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
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if(stations.data.count > 0) {
                        ScrollView(.vertical) {
                            ForEach(stations.data, id: \.id) { stationGroup in
                                VStack {
                                    RailHeading(text: stationGroup.title)
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(stationGroup.data, id: \.id) { station in
                                                StationSquare(station: station)
                                            } .padding(.trailing, 20)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } .accessibilityHidden(config.status.isOn ? false : true)
                Group {
                    if(config.status.isOn == false) {
                        // Popup box with a message how it isn't valid
                        VStack {
                            Text(config.status.title)
                            Text(config.status.message)
                            Link(config.status.linkTitle, destination: config.status.appStoreUrl).foregroundColor(.blue)
                        } .accessibilityElement(children: .combine) // Read out all as one rather than individual links
                            .accessibilityLabel(Text("\(config.status.title)  \(config.status.message) \(config.status.linkTitle)"))
                            .padding(10)
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("BBC Mini Sounds")
            .onAppear {
                setupConfigJSON()
            }
        }
    }
    
}

//struct ListenPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListenPageView()
//    }
//}
