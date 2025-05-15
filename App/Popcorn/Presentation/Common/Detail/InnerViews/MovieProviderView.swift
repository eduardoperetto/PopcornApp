//
//  MovieProviderView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import PopcornCore
import SwiftUI

struct MovieProviderView: View {
    let provider: MovieProvider

    var body: some View {
        VStack(spacing: 8) {
            PopcornAsyncImageView(
                imageUrl: .buildImageURL(for: provider.logoPath, quality: .low, baseUrl: AppDI.container.environment.imageBaseUrl),
                height: 60,
                width: 60
            )
            Text(provider.name)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MovieProviderView(
        provider: .init(id: 1, name: "Provider", logoPath: "/gcXCMxpFaYt3p2bT36rfThhKeG3.png")
    )
}
