//
//  FilterableView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import SwiftUI

struct FilterableView: ViewModifier {
    @ObservedObject var viewModel: FilterableViewModel

    func body(content: Content) -> some View {
        VStack {
            FilterChipStackView(viewModel: viewModel)
            content
                .sheet(isPresented: $viewModel.presentFilterSheet) {
                    FilterSheetView(viewModel: viewModel)
                }
        }
    }
}

extension View {
    func filterable(viewModel: FilterableViewModel) -> some View {
        modifier(FilterableView(viewModel: viewModel))
    }
}
