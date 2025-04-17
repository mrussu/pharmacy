package dev.mrussu.pharmacy.db

import dev.mrussu.pharmacy.models.Medication
import java.sql.Connection

object MedicationRepository {

    fun getAll(connection: Connection): List<Medication> {
        val medications = mutableListOf<Medication>()
        val statement = connection.createStatement()
        val result = statement.executeQuery("SELECT * FROM medication_use_by")

        while (result.next()) {
            medications.add(
                Medication(
                    id = result.getInt("id"),
                    name = result.getString("name"),
                    form = result.getString("form"),
                    useByDays = result.getInt("use_by_days"),
                    location = result.getString("location")
                )
            )
        }
        return medications
    }
}