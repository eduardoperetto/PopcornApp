//
//  WrapView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct WrapView: View {
    let items: [String]
    let spacing: CGFloat = 8
    let lineSpacing: CGFloat = 8

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemFill))
                    .cornerRadius(8)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height + lineSpacing
                        }
                        let result = width
                        if item == items.last {
                            width = 0
                        } else {
                            width -= d.width + spacing
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if item == items.last {
                            height = 0
                        }
                        return result
                    }
            }
        }
    }
}
