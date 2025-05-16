package com.eduardoperetto.popcornshared.domain

class FetchMovieDetailsUseCase(private val repository: MovieRepository) {
    suspend fun invoke(movieId: Int): Response<MovieDetails> =
        repository.fetchMovieDetails(movieId)
}