package com.eduardoperetto.popcornshared.domain

fun FilterOptions.getActiveFilters(): List<FilterDescription> {
    val filters = mutableListOf<FilterDescription>()

    language?.let {
        filters.add(FilterDescription(DefaultFilterKey.language, it.name))
    }
    primaryReleaseYear?.let {
        filters.add(FilterDescription(DefaultFilterKey.primaryReleaseYear, it.toString()))
    }
    releaseDateRange?.let { range ->
        range.start?.let { filters.add(
            FilterDescription(
                DefaultFilterKey.releaseDateGte,
                "After $it"
            )
        ) }
        range.end?.let { filters.add(
            FilterDescription(
                DefaultFilterKey.releaseDateLte,
                "Before $it"
            )
        ) }
    }
    if (sortBy != SortOption.popularityDesc) {
        filters.add(FilterDescription(DefaultFilterKey.sortBy, sortBy.description))
    }
    voteRange?.let { range ->
        range.min?.let { filters.add(
            FilterDescription(
                DefaultFilterKey.voteAverageGte,
                "Vote rate > $it"
            )
        ) }
        range.max?.let { filters.add(
            FilterDescription(
                DefaultFilterKey.voteAverageLte,
                "Vote rate < $it"
            )
        ) }
    }
    movieGenre?.let {
        filters.add(FilterDescription(DefaultFilterKey.movieGenre, it.name))
    }
    return filters
}