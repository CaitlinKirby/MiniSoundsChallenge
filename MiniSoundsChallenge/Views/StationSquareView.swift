//
//  StationView.swift
//  MiniSoundsChallenge
//
//  Created by Caitlin Kirby on 12/06/2023.
//

import SwiftUI

struct StationSquareView: View {
    
    private let viewModel: StationSquareViewModel
    
    init(viewModel: StationSquareViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            RadioIcon(imageUrl: viewModel.imageUrl)
            Text(viewModel.title)
                .font(.title3)
                .frame(maxWidth: 150, minHeight: 50, maxHeight: 75)
                .multilineTextAlignment(.center)
            Text(viewModel.subtitle)
                .font(.system(size:15))
                .frame(maxWidth: 150, minHeight: 50)
                .padding(.bottom, 20)
        }
        .accessibilityLabel(Text("\(viewModel.title).  \(viewModel.subtitle)"))
    }
}

private struct RadioIcon: View {
    var imageUrl: String
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: imageUrl.replacingOccurrences(of: "{recipe}", with: "320x320")),
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
