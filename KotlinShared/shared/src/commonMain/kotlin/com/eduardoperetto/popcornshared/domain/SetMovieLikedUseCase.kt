package com.eduardoperetto.popcornshared.domain

class SetMovieLikedUseCase(private val repository: MovieRepository) {
    suspend fun invoke(movie: Movie, isLiked: Boolean): Response<Unit> =
        if (isLiked) repository.storeLikedMovie(movie) else repository.removeLikedMovie(movie)
}