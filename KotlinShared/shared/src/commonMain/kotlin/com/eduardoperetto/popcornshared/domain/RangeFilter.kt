package com.eduardoperetto.popcornshared.domain

data class RangeFilter<T : Comparable<T>>(
    var min: T? = null,
    var max: T? = null
)