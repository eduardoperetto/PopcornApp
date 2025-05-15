//
//  FilterChipStackView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import SwiftUI
import PopcornCore

struct FilterChipStackView: View {
    @ObservedObject var viewModel: FilterableViewModel

    var filterSheetIcon: Image {
        Image(systemName: "slider.horizontal.3")
    }

    var resetFilterIcon: Image {
        Image(systemName: "xmark")
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                FilterChipView(icon: filterSheetIcon) { viewModel.openFilterSheet() }
                ForEach(viewModel.appliedFilters.getActiveFilters()) { filter in
                    FilterChipView(icon: resetFilterIcon, description: filter.value.capitalized) { viewModel.resetFilter(filter.keyType) }
                }
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}

#Preview {
    let useCase = AppDI.container.fetchMoviesUseCase
    let viewModel = DiscoverViewModel(coordinator: DiscoverCoordinator(), fetchMoviesListUseCase: useCase)
    viewModel.applyFilters(
        FilterOptions(
            language: SpokenLanguage.allCases.first,
            primaryReleaseYear: 2024,
            releaseDateRange: .init(start: "30/05/2024"),
            sortBy: .voteAverageDesc,
            voteRange: .init(min: 6.0),
            movieGenre: .init(id: 1, name: "War")
        )
    )
    return FilterChipStackView(viewModel: viewModel)
}
