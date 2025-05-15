//
//  LikeButton.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct LikeButton: View {
    let isLiked: Bool
    let action: () -> Void

    @State private var animate = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animate = false
                }
                action()
            }
        }) {
            HStack(spacing: 8) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .symbolEffect(.bounce, value: isLiked)
                    .scaleEffect(animate ? 1.2 : 1.0)

                Text(isLiked ? "Liked" : "Like")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(isLiked ? Color.pink.opacity(0.2) : Color.gray.opacity(0.2))
            .foregroundColor(isLiked ? .pink : .primary)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isLiked ? Color.pink : Color.gray, lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
