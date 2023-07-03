//
//  RailView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 20/06/2023.
//

import SwiftUI

struct RailView: View {
    @ObservedObject var viewModel: RailViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.stations, id: \.id) { station in
                        StationSquareView(viewModel: StationSquareModel(
                            id: station.id,
                            title: station.titles.primary,
                            subtitle: station.synopses.short,
                            imageUrl: station.image_url))
                            .onTapGesture {
                                viewModel.tapped(stationID: station.id)
                            }
                    } .padding(.trailing, 20)
                }
            }
        }
    }
}

