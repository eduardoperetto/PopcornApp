package com.eduardoperetto.popcornshared.domain

// Domain error cases
sealed class DomainError {
    object NetworkError : DomainError()
    object NotFound : DomainError()
    data class Unknown(val message: String?) : DomainError()
}