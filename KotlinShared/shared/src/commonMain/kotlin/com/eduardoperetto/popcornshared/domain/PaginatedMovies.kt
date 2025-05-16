package com.eduardoperetto.popcornshared.domain

// Pagination
data class PaginatedMovies(
    val page: Int,
    val totalPages: Int,
    val totalResults: Int,
    val movies: List<Movie>
)