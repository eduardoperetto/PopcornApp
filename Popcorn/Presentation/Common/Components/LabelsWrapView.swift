//
//  LabelsWrapView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct LabelsWrapView: View {
    let items: [String]
    let spacing: CGFloat = 8
    let lineSpacing: CGFloat = 8

    var body: some View {
        FlowLayout(spacing: spacing, lineSpacing: lineSpacing) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemFill))
                    .cornerRadius(8)
            }
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat
    var lineSpacing: CGFloat

    init(spacing: CGFloat = 8, lineSpacing: CGFloat = 8) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
    }

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        let maxWidth = proposal.width ?? .infinity

        var lineWidth: CGFloat = 0
        var lineHeight: CGFloat = 0

        var totalHeight: CGFloat = 0

        for sub in subviews {
            let size = sub.sizeThatFits(.unspecified)

            if lineWidth + size.width > maxWidth {
                totalHeight += lineHeight + lineSpacing
                lineWidth = 0
                lineHeight = 0
            }

            lineWidth += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }

        totalHeight += lineHeight

        let finalWidth = proposal.width ?? min(maxWidth, lineWidth)
        return CGSize(width: finalWidth, height: totalHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var currentLineHeight: CGFloat = 0

        for sub in subviews {
            let size = sub.sizeThatFits(.unspecified)

            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += currentLineHeight + lineSpacing
                currentLineHeight = 0
            }

            sub.place(
                at: CGPoint(x: x, y: y),
                proposal: .init(width: size.width, height: size.height)
            )

            x += size.width + spacing
            currentLineHeight = max(currentLineHeight, size.height)
        }
    }
}

#Preview {
    LabelsWrapView(items: SpokenLanguage.allCases.map { $0.englishName })
}
