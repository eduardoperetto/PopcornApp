package com.eduardoperetto.popcornshared.domain

class SetMovieWatchLaterUseCase(private val repository: MovieRepository) {
    suspend fun invoke(movie: Movie, watchLater: Boolean): Response<Unit> =
        if (watchLater) repository.storeWatchLaterMovie(movie) else repository.removeWatchLaterMovie(movie)
}