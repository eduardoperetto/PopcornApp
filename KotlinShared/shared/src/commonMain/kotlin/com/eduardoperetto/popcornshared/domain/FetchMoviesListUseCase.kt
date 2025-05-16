package com.eduardoperetto.popcornshared.domain

class FetchMoviesListUseCase(private val repository: MovieRepository) {
    suspend fun invoke(filters: FilterOptions? = null, page: Int): Response<PaginatedMovies> =
        repository.fetchMovies(filters, page)
}