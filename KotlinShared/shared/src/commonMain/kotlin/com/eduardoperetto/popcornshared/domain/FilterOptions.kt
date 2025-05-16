package com.eduardoperetto.popcornshared.domain

data class FilterOptions(
    var language: SpokenLanguage? = null,
    var primaryReleaseYear: Int? = null,
    var releaseDateRange: DateRangeFilter? = null,
    var sortBy: SortOption = SortOption.popularityDesc,
    var voteRange: RangeFilter<Double>? = null,
    var movieGenre: MovieGenre? = null
) {
    companion object {
        val defaultFilter = FilterOptions()
    }
}