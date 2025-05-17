package dev.mrussu.pharmacy.models

data class XR2Tray(
    val id: Int,
    val type: String,
    val slots: Int,
    val cols: Int,
    val rows: Int,
    val cells: Int = cols * rows,
    val color: String? = null
)