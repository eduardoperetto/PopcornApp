package com.eduardoperetto.popcornshared.domain

data class MovieDetails(
    val id: Int,
    val title: String,
    val tagline: String,
    val overview: String,
    val releaseDate: String,
    val genres: Set<MovieGenre>,
    val runtime: Int,
    val budget: Double,
    val revenue: Double,
    val voteAverage: Double,
    val voteCount: Int,
    val backdropPath: String?,
    val posterPath: String?,
    val homepage: String?,
    val productionCompanies: Set<ProductionCompany>,
    val spokenLanguages: Set<SpokenLanguage>,
    val status: String,
    val movieProviders: Set<MovieProvider>,
    val isLiked: Boolean,
    val isSetToWatchLater: Boolean
)