//
//  WatchLaterButton.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct WatchLaterButton: View {
    let isSaved: Bool
    let action: () -> Void

    @State private var animating = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                animating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animating = false
                }
                action()
            }
        }) {
            HStack(spacing: 8) {
                Image(systemName: isSaved ? "bookmark.fill" : "clock.badge.checkmark.fill")
                    .symbolEffect(.bounce, value: isSaved)
                    .scaleEffect(animating ? 1.1 : 1.0)

                Text(isSaved ? "Saved For Later" : "Watch Later")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(isSaved ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
            .foregroundColor(isSaved ? .blue : .primary)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSaved ? Color.blue : Color.gray, lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
