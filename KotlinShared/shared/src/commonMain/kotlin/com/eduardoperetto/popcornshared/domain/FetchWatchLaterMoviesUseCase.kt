package com.eduardoperetto.popcornshared.domain

class FetchWatchLaterMoviesUseCase(private val repository: MovieRepository) {
    suspend fun invoke(): Response<List<Movie>> =
        repository.fetchWatchLaterMovies()
}