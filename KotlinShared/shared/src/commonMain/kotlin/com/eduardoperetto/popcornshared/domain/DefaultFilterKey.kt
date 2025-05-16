package com.eduardoperetto.popcornshared.domain

enum class DefaultFilterKey(override val id: String, override val displayName: String) : FilterKey {
    language("language", "Language"),
    primaryReleaseYear("primaryReleaseYear", "Release Year"),
    releaseDateGte("releaseDateGte", "Release Date From"),
    releaseDateLte("releaseDateLte", "Release Date To"),
    sortBy("sortBy", "Sort By"),
    voteAverageGte("voteAverageGte", "Min Rating"),
    voteAverageLte("voteAverageLte", "Max Rating"),
    movieGenre("movieGenre", "Genres");
}