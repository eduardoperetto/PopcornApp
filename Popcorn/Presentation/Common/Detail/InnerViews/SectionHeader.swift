//
//  SectionHeader.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 12/05/25.
//

import SwiftUI

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline.bold())
            .foregroundColor(.primary)
            .padding(.vertical, 4)
    }
}
