package com.eduardoperetto.popcornshared.domain

// Sorting and Filtering
enum class SortOption(val value: String, val description: String) {
    popularityDesc("popularity.desc", "Descending popularity"),
    releaseDateDesc("release_date.desc", "Descending release date"),
    voteAverageDesc("vote_average.desc", "Descending vote rating");
}