package dev.mrussu.pharmacy

import dev.mrussu.pharmacy.config.*
import dev.mrussu.pharmacy.routes.configureRouting
import io.ktor.server.application.*

fun main(args: Array<String>) {
    io.ktor.server.netty.EngineMain.main(args)
}

fun Application.module() {
    configureTemplating()
    configureSerialization()
    configureDatabases()
    configureRouting()
}
