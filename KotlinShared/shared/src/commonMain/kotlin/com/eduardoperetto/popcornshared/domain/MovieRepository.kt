package com.eduardoperetto.popcornshared.domain

// Repository Interface
interface MovieRepository {
    suspend fun fetchMovies(filtering: FilterOptions?, page: Int): Response<PaginatedMovies>
    suspend fun fetchMovieDetails(id: Int): Response<MovieDetails>

    suspend fun fetchLikedMovies(): Response<List<Movie>>
    suspend fun storeLikedMovie(movie: Movie): Response<Unit>
    suspend fun removeLikedMovie(movie: Movie): Response<Unit>

    suspend fun fetchWatchLaterMovies(): Response<List<Movie>>
    suspend fun storeWatchLaterMovie(movie: Movie): Response<Unit>
    suspend fun removeWatchLaterMovie(movie: Movie): Response<Unit>
}