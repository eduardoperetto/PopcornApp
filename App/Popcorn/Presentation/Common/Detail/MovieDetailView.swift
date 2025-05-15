//
//  MovieDetailsView.swift
//  Popcorn
//
//  Created by Eduardo Raupp Peretto on 08/05/25.
//
import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        Group {
            if viewModel.state.isLoading {
                ProgressView()
                    .scaleEffect(2)
            } else if viewModel.state.movie != nil {
                contentView
            } else if let error = viewModel.state.error {
                ErrorView(state: error)
            }
        }
        .refreshable {
            viewModel.fetchMovieData()
        }
        .navigationTitle(viewModel.state.movie?.title ?? "Loading Movie")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Main Content Views

    private var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                headerSection
                actionButtons
                infoGridSection
                bannerView
                overviewSection
                providersSection
                productionSection
                languagesSection
                statusSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                ZStack {
                    Color.lightGrayBg
                    if let movie = viewModel.state.movie?.toMovie() {
                        MoviePosterImageView(movie: movie)
                    }
                }.frame(width: 120)

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.state.movie?.title ?? "")
                        .font(.title2.bold())
                        .foregroundColor(.primary)

                    Text(viewModel.state.movie?.tagline ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    if let rating = viewModel.state.movie?.voteAverage {
                        RatingView(rating: rating)
                    }
                }
            }
        }
    }

    private var infoGridSection: some View {
        let columns: [GridItem] = sizeClass == .compact ?
            Array(repeating: .init(.flexible()), count: 2) :
            Array(repeating: .init(.flexible()), count: 4)

        return LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
            if let movie = viewModel.state.movie {
                InfoCell(title: "Release Date", value: movie.releaseDate.formattedDate)
                if movie.runtime.isNotZero {
                    InfoCell(title: "Runtime", value: movie.runtime.formattedRuntime)
                }
                if movie.budget.isNotZero {
                    InfoCell(title: "Budget", value: movie.budget.formattedCurrency)
                }
                if movie.revenue.isNotZero {
                    InfoCell(title: "Revenue", value: movie.revenue.formattedCurrency)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    private var bannerView: some View {
        PopcornAsyncImageView(
            imageUrl: .buildImageURL(for: viewModel.state.movie?.backdropPath, quality: .high, baseUrl: AppDI.container.environment.imageBaseUrl),
            height: 200
        )
    }

    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Overview")
            Text(viewModel.state.movie?.overview ?? "")
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
    }

    private var actionButtons: some View {
        HStack(spacing: 20) {
            LikeButton(isLiked: viewModel.state.movie?.isLiked ?? false) {
                viewModel.toggleLike()
            }

            WatchLaterButton(isSaved: viewModel.state.movie?.isSetToWatchLater ?? false) {
                viewModel.toggleWatchLater()
            }
        }
        .padding(.horizontal, 20)
    }

    private var providersSection: some View {
        Group {
            if let movie = viewModel.state.movie, !movie.movieProviders.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    SectionHeader(title: "Streaming Providers")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(Array(movie.movieProviders)) { provider in
                                MovieProviderView(provider: provider)
                            }
                        }
                    }
                }
            }
        }
    }

    private var productionSection: some View {
        Group {
            if let movie = viewModel.state.movie, !movie.productionCompanies.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    SectionHeader(title: "Production Companies")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(Array(movie.productionCompanies)) { company in
                                ProductionCompanyView(company: company)
                            }
                        }
                    }
                }
            }
        }
    }

    private var languagesSection: some View {
        Group {
            if let movie = viewModel.state.movie, !movie.spokenLanguages.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    SectionHeader(title: "Spoken Languages")
                    LabelsWrapView(items: movie.spokenLanguages.map { $0.englishName })
                }
            }
        }
    }

    private var statusSection: some View {
        HStack {
            if let movie = viewModel.state.movie {
                Text("Status: \(movie.status)")
                    .font(.callout)
                    .foregroundColor(.secondary)

                if let homepage = movie.homepage, let url = URL(string: homepage) {
                    Spacer()
                    Link("Official Website", destination: url)
                        .buttonStyle(.borderedProminent)
                        .tint(.primaryForeground)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

#Preview {
    let viewModel = MovieDetailsViewModel(
        movieId: 370172,
        fetchMovieDetailsUseCase: AppDI.container.fetchMovieDetailsUseCase,
        setMovieLikedUseCase: AppDI.container.setMovieLikedUseCase,
        setMovieWatchLaterUseCase: AppDI.container.setMovieWatchLaterUseCase
    )
    MovieDetailsView(viewModel: viewModel)
}
