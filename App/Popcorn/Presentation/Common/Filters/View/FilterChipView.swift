//
//  FilterChipView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 13/10/24.
//

import SwiftUI

struct FilterChipView: View {
    let icon: Image?
    let description: String?
    let onTap: () -> Void
    @State var bgColor: Color
    let foregroundColor: Color
    @State private var isTapped = false

    init(
        icon: Image? = nil,
        description: String? = nil,
        onTap: @escaping () -> Void,
        bgColor: Color = .background,
        foregroundColor: Color = .filterForeground
    ) {
        self.icon = icon
        self.description = description
        self.onTap = onTap
        self.bgColor = bgColor
        self.foregroundColor = foregroundColor
    }

    var iconSize: CGFloat {
        description != nil ? 14 : 22
    }

    var body: some View {
        HStack {
            if let icon {
                icon
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            if let description {
                Text(description)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .background(bgColor)
        .foregroundStyle(foregroundColor)
        .cornerRadius(5)
//        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        .scaleEffect(isTapped ? 0.95 : 1.0)
        .onTapGesture {
            withAnimation {
                isTapped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isTapped = false
                }
                onTap()
            }
        }
    }
}

#Preview {
    FilterChipView(icon: Image(systemName: "slider.horizontal.3"), description: "Filter") { print("openFilter") }
}
