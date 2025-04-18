package dev.mrussu.pharmacy.routes

import dev.mrussu.pharmacy.db.Database
import dev.mrussu.pharmacy.db.MedicationRepository
import dev.mrussu.pharmacy.models.Link
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.http.content.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.io.File
import java.time.LocalDate
import java.time.format.DateTimeFormatter

fun Application.configureRouting() {
    routing {
        head("/health") {
            call.respond(HttpStatusCode.OK)
        }

        route("/pharmacy") {
            get("/") {
                val menu = listOf(
                    Link("Use By Dates", "use-by")
                )

                call.respond(
                    FreeMarkerContent(
                        template = "index.ftl",
                        model = mapOf(
                            "menu" to menu
                        )
                    )
                )
            }
            get("/use-by") {
                val formatter = DateTimeFormatter.ofPattern("MM/dd/yy")
                val today = LocalDate.now()
                val medications = MedicationRepository.getAll(Database.connection).map {
                    mapOf(
                        "name" to it.name,
                        "form" to it.form,
                        "useByDays" to it.useByDays,
                        "useBy" to today.plusDays(it.useByDays.toLong()).format(formatter),
                        "location" to it.location
                    )
                }

                call.respond(
                    FreeMarkerContent(
                        template = "use-by.ftl",
                        model = mapOf(
                            "today" to today.format(formatter),
                            "medications" to medications
                        )
                    )
                )
            }
            staticFiles("/static", File("static"))
        }
    }
}
