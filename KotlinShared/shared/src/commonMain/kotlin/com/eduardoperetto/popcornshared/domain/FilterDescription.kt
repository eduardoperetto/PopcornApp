package com.eduardoperetto.popcornshared.domain

data class FilterDescription(
    val keyType: FilterKey,
    val value: String
) {
    val id: String get() = keyType.id
}