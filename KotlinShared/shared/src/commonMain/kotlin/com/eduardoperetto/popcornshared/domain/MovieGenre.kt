package com.eduardoperetto.popcornshared.domain

data class MovieGenre(
    override val name: String,
    val id: Int
) : SelectionPickable {
    companion object {
        val allCases: List<MovieGenre> = listOf(
            MovieGenre("Action", 28),
            MovieGenre("Adventure", 12),
            MovieGenre("Animation", 16),
            MovieGenre("Comedy", 35),
            MovieGenre("Crime", 80),
            MovieGenre("Documentary", 99),
            MovieGenre("Drama", 18),
            MovieGenre("Family", 10751),
            MovieGenre("Fantasy", 14),
            MovieGenre("History", 36),
            MovieGenre("Horror", 27),
            MovieGenre("Music", 10402),
            MovieGenre("Mystery", 9648),
            MovieGenre("Romance", 10749),
            MovieGenre("Science Fiction", 878),
            MovieGenre("TV Movie", 10770),
            MovieGenre("Thriller", 53),
            MovieGenre("War", 10752),
            MovieGenre("Western", 37)
        )
    }
}