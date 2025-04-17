package dev.mrussu.pharmacy.models

data class Medication(
    val id: Int,
    val name: String,
    val form: String,
    val useByDays: Int,
    val location: String?
)