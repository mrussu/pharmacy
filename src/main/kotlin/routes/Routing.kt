package dev.mrussu.pharmacy.routes

import dev.mrussu.pharmacy.db.Database
import dev.mrussu.pharmacy.db.MedicationRepository
import dev.mrussu.pharmacy.db.XR2Repository
import dev.mrussu.pharmacy.models.Link
import dev.mrussu.pharmacy.models.Medication
import dev.mrussu.pharmacy.models.XR2Tray
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
    val formatter = DateTimeFormatter.ofPattern("MM/dd/yy")

    routing {
        head("/health") {
            call.respond(HttpStatusCode.OK)
        }

        route("/pharmacy") {
            get("/") {
                val menu = listOf(
                    Link("Use By Date Calculator", "use-by/calc"),
                    Link("Use By Dates by Medication", "use-by/meds"),
                    Link("XR2 Tray Guide", "xr2/tray-guide")
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
            get("/use-by/calc") {
                val today = LocalDate.now()

                call.respond(
                    FreeMarkerContent(
                        template = "use-by-calc.ftl",
                        model = mutableMapOf(
                            "mode" to "calc",
                            "today" to today.format(formatter)
                        )
                    )
                )
            }
            get("/use-by/meds") {
                val today = LocalDate.now()

                call.respond(
                    FreeMarkerContent(
                        template = "use-by-meds.ftl",
                        model = mutableMapOf(
                            "mode" to "meds",
                            "meds" to getMedications(today, formatter),
                            "today" to today.format(formatter)
                        )
                    )
                )
            }
            get("/xr2/tray-guide") {
                val trays = getXR2Trays()

                call.respond(
                    FreeMarkerContent(
                        template = "xr2-tray-guide.ftl",
                        model = mutableMapOf(
                            "trays" to trays,
                        )
                    )
                )
            }
            staticFiles("/static", File("static"))
        }
    }
}

fun getMedications(today: LocalDate, formatter: DateTimeFormatter): List<Medication> {
    return MedicationRepository.getAll(Database.connection).map {
        Medication(
            id = it.id,
            name = it.name,
            form = it.form,
            useByDays = it.useByDays,
            useBy = today.plusDays(it.useByDays.toLong()).format(formatter),
            location = it.location
        )
    }
}

fun getXR2Trays(): List<XR2Tray> {
    return XR2Repository.getTransferTrays(Database.connection)
}