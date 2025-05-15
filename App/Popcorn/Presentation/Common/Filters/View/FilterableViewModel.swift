//
//  FilterableViewModel.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 11/05/25.
//

import Foundation
import PopcornCore

open class FilterableViewModel: ObservableObject {
    @Published var presentFilterSheet: Bool = false
    @Published var appliedFilters: FilterOptions = .init()

    func applyFilters(_ filters: FilterOptions) {
        appliedFilters = filters
        presentFilterSheet = false
        onFiltersApplied(filters)
    }

    func onFiltersApplied(_ filters: FilterOptions) {}

    func resetFilter(_ filterKey: FilterKey) {
        appliedFilters.reset(filterKey)
        onFiltersApplied(appliedFilters)
    }

    func openFilterSheet() {
        presentFilterSheet = true
    }

    func closeFilterSheet() {
        presentFilterSheet = false
    }
}
