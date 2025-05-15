//
//  ProductionCompanyView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import PopcornCore
import SwiftUI

struct ProductionCompanyView: View {
    let company: ProductionCompany

    var body: some View {
        VStack(spacing: 8) {
            PopcornAsyncImageView(
                imageUrl: .buildImageURL(for: company.logoPath, quality: .low, baseUrl: AppDI.container.environment.imageBaseUrl),
                height: 60,
                width: 60,
                scaleToFill: false
            )
            Text(company.name)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
