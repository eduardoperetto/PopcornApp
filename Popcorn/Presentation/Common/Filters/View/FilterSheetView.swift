//
//  FilterSheetView.swift
//  AwesomeNews
//
//  Created by Eduardo Raupp Peretto on 12/10/24.
//

import SwiftUI

struct FilterSheetView: View {
    @ObservedObject var viewModel: FilterableViewModel
    @State private var currentFilterSelection: FilterOptions
    private let currentYear = Calendar.current.component(.year, from: Date())

    init(viewModel: FilterableViewModel) {
        self.viewModel = viewModel
        self.currentFilterSelection = viewModel.appliedFilters
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        genreSection
                        sortBySection
                        languageSection
                        releaseYearSection
                        releaseDateRangeSection
                        voteRangeSection
                    }
                    .padding(.vertical)
                }

                actionButtons
            }
            .background(Color(.systemBackground))
            .navigationTitle("Filter Movies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.closeFilterSheet()
                    }
                    .foregroundColor(.primaryForeground)
                }
            }
            .tint(.primaryForeground)
        }
    }

    // MARK: - Filter Sections

    private var languageSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Language")
                .font(.headline)
            Picker("Select Language", selection: $currentFilterSelection.language.wrapOptional) {
                ForEach(OptionalWrapper<SpokenLanguage>.allCases, id: \.self) { language in
                    Text(language.description)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }

    private var releaseYearSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Primary Release Year")
                .font(.headline)
            TextField("Enter year (e.g., \(currentYear.description))",
                      text: Binding(
                          get: { currentFilterSelection.primaryReleaseYear?.description ?? "" },
                          set: { currentFilterSelection.primaryReleaseYear = Int($0) }
                      ))
                      .keyboardType(.numberPad)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }

    private var releaseDateRangeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Release Date Range")
                .font(.headline)
            DateSelectionView(
                startDate: Binding(
                    get: { currentFilterSelection.releaseDateRange?.start?.toDate() ?? Date() },
                    set: { currentFilterSelection.releaseDateRange?.start = $0.toString() }
                ),
                endDate: Binding(
                    get: { currentFilterSelection.releaseDateRange?.end?.toDate() ?? Date() },
                    set: { currentFilterSelection.releaseDateRange?.end = $0.toString() }
                )
            )
        }
        .padding(.horizontal)
    }

    private var sortBySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Sort By")
                .font(.headline)
            Picker("Sort By", selection: $currentFilterSelection.sortBy) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Text(option.description).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }

    private var voteRangeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Vote Average Range")
                .font(.headline)
            HStack {
                TextField("Min",
                          text: Binding(
                              get: { currentFilterSelection.voteRange?.min?.description ?? "" },
                              set: { currentFilterSelection.voteRange?.min = Double($0) }
                          ))
                          .keyboardType(.decimalPad)
                          .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("to")

                TextField("Max",
                          text: Binding(
                              get: { currentFilterSelection.voteRange?.max?.description ?? "" },
                              set: { currentFilterSelection.voteRange?.max = Double($0) }
                          ))
                          .keyboardType(.decimalPad)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding(.horizontal)
    }

    private var genreSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Genre")
                .font(.headline)
            Picker("Select Genre", selection: $currentFilterSelection.movieGenre.wrapOptional) {
                ForEach(OptionalWrapper<MovieGenre>.allCases, id: \.self) { genre in
                    Text(genre.description)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding(.horizontal)
    }

    // MARK: - Action Buttons

    private var actionButtons: some View {
        HStack(spacing: 20) {
            resetButton
            applyButton
        }
        .padding(.horizontal)
        .padding(.bottom)
    }

    private var resetButton: some View {
        Button(action: resetFilters) {
            Text("Reset")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }

    private var applyButton: some View {
        Button(action: {
            viewModel.applyFilters(currentFilterSelection)
        }) {
            Text("Apply")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.primaryForeground)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

    private func resetFilters() {
        currentFilterSelection = FilterOptions()
    }
}

#Preview {
    FilterSheetView(
        viewModel: DiscoverViewModel(
            coordinator: DiscoverCoordinator(), fetchMoviesListUseCase: AppDI.container.fetchMoviesUseCase
        )
    )
}
