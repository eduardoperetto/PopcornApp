package com.eduardoperetto.popcornshared.domain

class FetchLikedMoviesUseCase(private val repository: MovieRepository) {
    suspend fun invoke(): Response<List<Movie>> =
        repository.fetchLikedMovies()
}