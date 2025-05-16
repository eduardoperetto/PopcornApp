package com.eduardoperetto.popcornshared.domain

// OptionalWrapper equivalent
sealed class OptionalWrapper<T : SelectionPickable> {
    data class Some<T : SelectionPickable>(val value: T) : OptionalWrapper<T>()
    class None<T : SelectionPickable> : OptionalWrapper<T>()

    val description: String
        get() = when (this) {
            is None -> "Not selected"
            is Some -> value.name
        }

    companion object {
        fun <T : SelectionPickable> from(value: T?): OptionalWrapper<T> =
            if (value != null) Some(value) else None()

        fun <T : SelectionPickable> allCases(all: List<T>): List<OptionalWrapper<T>> {
            val cases = all.map { Some(it) }
            return cases + None()
        }
    }
}