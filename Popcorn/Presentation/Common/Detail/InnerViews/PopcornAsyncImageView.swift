//
//  PopcornAsyncImageView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct PopcornAsyncImageView: View {
    let imageUrl: URL?

    let height: CGFloat?
    let width: CGFloat?
    let aspectRatio: CGFloat?
    let scaleToFill: Bool

    @State private var didLoad: Bool = false

    init(
        imageUrl: URL?,
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        aspectRatio: CGFloat? = nil,
        scaleToFill: Bool = true
    ) {
        self.imageUrl = imageUrl
        self.height = height
        self.width = width
        self.aspectRatio = aspectRatio
        self.scaleToFill = scaleToFill
    }

    var body: some View {
        ZStack {
            Color.lightGrayBg
                .opacity(didLoad ? 0 : 1)

            if let imageUrl {
                AsyncImage(url: imageUrl) { phase in
                    if let image = phase.image {
                        adjustImage(image)
                            .onAppear { self.didLoad = true }
                    } else if phase.error != nil {
                        loadFailedImage
                    } else {
                        ProgressView()
                            .frame(height: height)
                            .progressViewStyle(CircularProgressViewStyle(tint: .darkForeground))
                    }
                }
            } else {
                loadFailedImage
            }
        }
        .frame(width: width, height: height)
        .aspectRatio(aspectRatio, contentMode: .fit)
        .clipped()
    }

    private func adjustImage(_ image: Image) -> some View {
        image
            .resizable()
            .if(scaleToFill) { $0.scaledToFill() }
            .if(!scaleToFill) { $0.scaledToFit() }
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(12)
    }

    private var loadFailedImage: some View {
        ZStack {
            Color.lightGrayBg
                .frame(width: width, height: height)

            Image(systemName: "xmark.icloud.fill")
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    PopcornAsyncImageView(
        imageUrl: .buildImageURL(for: "/gcXCMxpFaYt3p2bT36rfThhKeG3.png", quality: .low),
        height: 120,
        width: 120,
        scaleToFill: false
    )
}
