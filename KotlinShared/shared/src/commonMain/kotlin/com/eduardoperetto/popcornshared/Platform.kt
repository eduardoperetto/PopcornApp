package com.eduardoperetto.popcornshared

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform