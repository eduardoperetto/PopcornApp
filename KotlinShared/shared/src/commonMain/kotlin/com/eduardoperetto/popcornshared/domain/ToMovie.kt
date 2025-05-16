package com.eduardoperetto.popcornshared.domain

// Mapping extension
fun MovieDetails.toMovie(): Movie =
    Movie(id, title, overview, posterPath, voteAverage)