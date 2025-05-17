package dev.mrussu.pharmacy.db

import dev.mrussu.pharmacy.models.XR2Tray
import java.sql.Connection

object XR2Repository {

    fun getTransferTrays(connection: Connection): List<XR2Tray> {
        val trays = mutableListOf<XR2Tray>()
        val statement = connection.createStatement()
        val result = statement.executeQuery("SELECT * FROM xr2_tray ORDER BY id;")

        while (result.next()) {
            trays.add(
                XR2Tray(
                    id = result.getInt("id"),
                    type = result.getString("type"),
                    slots = result.getInt("slots"),
                    cols = result.getInt("cols"),
                    rows = result.getInt("rows"),
                    color = result.getString("color")
                )
            )
        }
        return trays
    }
}