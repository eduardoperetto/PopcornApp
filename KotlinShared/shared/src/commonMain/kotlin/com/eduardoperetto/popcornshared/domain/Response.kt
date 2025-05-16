package com.eduardoperetto.popcornshared.domain

sealed class Response<T> {
    data class Success<T>(val data: T) : Response<T>()
    data class Failure<T>(val error: DomainError) : Response<T>()

    fun onSuccess(action: (T) -> Unit): Response<T> = apply {
        if (this is Success) action(data)
    }

    fun onFailure(action: (DomainError) -> Unit): Response<T> = apply {
        if (this is Failure) action(error)
    }

    companion object {
        fun <T> success(data: T): Response<T> = Success(data)
        fun <T> failure(error: DomainError): Response<T> = Failure(error)
    }
}