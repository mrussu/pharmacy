package dev.mrussu.pharmacy.db

import java.sql.Connection

object DatabaseInitializer {

    fun initialize(connection: Connection) {
        val statement = connection.createStatement()
        val createMedicationsTable = """
            CREATE TABLE IF NOT EXISTS medication_use_by (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                form VARCHAR(100) NOT NULL,
                use_by_days INT NOT NULL,
                location VARCHAR(255),
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """.trimIndent()

        statement.executeUpdate(createMedicationsTable)

        val result = statement.executeQuery("SELECT COUNT(*) FROM medication_use_by")
        val count = if (result.next()) result.getInt(1) else 0

        if (count == 0) {
            val seedMedicationsTable = """
                INSERT INTO medication_use_by (name, form, use_by_days, location) VALUES
                    ('Humulin R U-500 (Insulin Regular)', 'Pen', 28, 'FRIDGE A-DOOR 2: 02-01-01'),
                    ('Humulin R U-100 (Insulin Regular)', 'Vial', 31, 'FRIDGE C-DOOR 2: 04-01-01'),
                    ('Humalog (Insulin Lispro)', 'Pen', 28, 'FRIDGE A-DOOR 2: 03-01-01'),
                    ('Humalog (Insulin Lispro)', 'Vial', 28, ''),
                    ('Novolog (Insulin Aspart)', 'Pen', 28, ''),
                    ('Novolog (Insulin Aspart)', 'Vial', 28, ''),
                    ('Apidra (Insulin Glulisine)', 'Pen', 28, ''),
                    ('Apidra (Insulin Glulisine)', 'Vial', 28, ''),
                    ('Humalog Mix 50/50', 'Pen', 10, ''),
                    ('Humalog Mix 50/50', 'Vial', 28, ''),
                    ('Humalog Mix 75/25', 'Pen', 10, ''),
                    ('Humalog Mix 75/25', 'Vial', 28, ''),
                    ('Novolog Mix 70/30', 'Pen', 14, ''),
                    ('Novolog Mix 70/30', 'Vial', 28, ''),
                    ('Humulin 70/30 (NPH/Regular)', 'Pen', 10, ''),
                    ('Humulin 70/30 (NPH/Regular)', 'Vial', 31, ''),
                    ('Humulin N (NPH - Insulin Isophane)', 'Pen', 14, ''),
                    ('Humulin N (NPH - Insulin Isophane)', 'Vial', 31, 'FRIDGE A-DOOR 2: 05-04-03'),
                    ('Lantus (Insulin Glargine)', 'Pen', 28, ''),
                    ('Lantus (Insulin Glargine)', 'Vial', 28, ''),
                    ('Levemir (Insulin Detemir)', 'Pen', 42, ''),
                    ('Levemir (Insulin Detemir)', 'Vial', 42, ''),
                    ('Toujeo (Insulin Glargine)', 'Pen', 56, ''),
                    ('Tresiba (Insulin Degludec)', 'Pen', 56, ''),
                    ('Tresiba (Insulin Degludec)', 'Vial', 56, ''),
                    ('Trulicity (Dulaglutide) 1.5mg', 'Pen', 14, 'FRIDGE A-DOOR 1: 04-01-03'),
                    ('Trulicity (Dulaglutide) 0.75mg', 'Pen', 14, 'FRIDGE A-DOOR 1: 04-01-01'),
                    ('Victoza (Liraglutide)', 'Pen', 30, ''),
                    ('Soliqua 100/33 (Insulin Glargine/Lixisenatide)', 'Pen', 28, ''),
                    ('Alteplase (Cathflo)', 'Vial', 120, 'FRIDGE A-DOOR 1: 01-01-01'),
                    ('Clevidipine (Cleviprex)', '', 60, ''),
                    ('Diltiazem', '', 30, ''),
                    ('Eptifibatide 75mg/100mL', 'Vial', 60, 'FRIDGE A-DOOR 1: 04-03-01'),
                    ('Eptifibatide 20mg/10mL', 'Vial', 60, 'FRIDGE A-DOOR 1: 04-03-03'),
                    ('Famotidine', '', 90, ''),
                    ('Latanoprost', 'Ophthalmic', 42, 'FRIDGE C-DOOR 1: 03-01-02'),
                    ('Lorazepam', '', 30, ''),
                    ('Rocuronium', 'Injection', 60, ''),
                    ('Succinylcholine', 'Injection', 14, ''),
                    ('Vasopressin', '', 365, ''),
                    ('SMOG', 'Enema', 30, ''),
                    ('SWOG (No Magnesium)', 'Enema', 30, ''),
                    ('Polyethylene Glycol & Gatorade', '', 5, '');
            """.trimIndent()

            statement.executeUpdate(seedMedicationsTable)
        }
        statement.close()
    }
}