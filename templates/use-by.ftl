<!doctype html>
<html dir="ltr" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/pharmacy/static/css/styles.css" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <title>Pharmacy | Use By Dates</title>
</head>
<body>
<div class="container">
    <h1>Calculate Use By Date</h1>
    <table>
        <thead>
            <tr>
                <th>Days Left</th>
                <th>Today</th>
                <th>Use By</th>
            </tr>
        </thead>
        <tr>
            <td><input type="number" id="daysLeft" class="select-on-focus" placeholder="Days Left" value="28" min="1" max="365" /></td>
            <td>${today}</td>
            <td class="column-use-by"><span id="useBy" class="use-by"></span></td>
        </tr>
    </table>
    <h1>Medication Use By Dates</h1>
    <table class="use-by-table">
        <thead>
            <tr>
                <th><input type="text" id="filter" class="select-on-focus" placeholder="Filter by name & form" /></th>
                <th class="column-form">Form</th>
                <th class="column-days">Days</th>
                <th class="column-use-by">Use By</th>
                <th class="column-location">Location</th>
            </tr>
        </thead>
        <tbody>
        <#list medications as med>
            <tr class="med-row"
                data-name="${med.name}"
                data-form="${med.form}"
                data-days="${med.useByDays}"
                data-expires="${med.useBy}"
                data-location="${med.location!''}">
                <td class="column-name">
                    ${med.name}
                    <#if med.form?has_content>
                        <span class="form-label">${med.form}</span>
                    </#if>
                </td>
                <td class="column-form">
                    <#if med.form?has_content>
                        <span class="form-label">${med.form}</span>
                    </#if>
                </td>
                <td class="column-days">${med.useByDays}</td>
                <td class="column-use-by"><span class="use-by">${med.useBy}</span></td>
                <td class="column-location">${med.location!''}</td>
            </tr>
        </#list>
        </tbody>
    </table>
    <div id="modal" class="modal hidden">
        <div class="modal-content">
            <div id="modal-header" class="modal-header">
                <span id="modal-title" class="modal-title"></span>
                <span id="modal-close" class="modal-close">&times;</span>
            </div>
            <div id="modal-body" class="modal-body"></div>
        </div>
    </div>
</div>
<script>
    function filterTable() {
        const input = document.getElementById("filter").value.toLowerCase();
        const rows = document.querySelectorAll(".use-by-table tbody tr");

        rows.forEach(row => {
            const name = row.dataset.name?.toLowerCase() || "";
            const form = row.dataset.form?.toLowerCase() || "";

            row.style.display = (name.includes(input) || form.includes(input)) ? "" : "none";
        });
    }

    function formatDate(date) {
        const mm = String(date.getMonth() + 1).padStart(2, '0');
        const dd = String(date.getDate()).padStart(2, '0');
        const yy = String(date.getFullYear()).slice(-2);
        return mm + '/' + dd + '/' + yy;
    }

    function updateUseBy() {
        const maxDigits = 3;
        const input = document.getElementById("daysLeft");
        const output = document.getElementById("useBy");

        input.value = input.value.replace(/[^0-9]/g, '');

        if (input.value.length > maxDigits) {
            input.value = input.value.slice(0, maxDigits);
        }

        let days = parseInt(input.value);

        if (!isNaN(days)) {
            days = Math.max(1, Math.min(days, 365));
            input.value = days;
            const today = new Date();
            today.setDate(today.getDate() + days);
            output.innerText = formatDate(today);
        } else {
            output.innerText = '';
        }
    }

    document.getElementById("daysLeft").addEventListener("input", updateUseBy);
    document.querySelectorAll(".med-row").forEach(row => {
        row.addEventListener("click", () => {
            const name = row.dataset.name;
            const form = row.dataset.form || '–';
            const days = row.dataset.days;
            const expires = row.dataset.expires;
            const location = row.dataset.location || '–';

            document.getElementById("modal-title").innerHTML = name;
            document.getElementById("modal-body").innerHTML =
                "<strong>Form:</strong> " + form + "<br>" +
                "<strong>Days:</strong> " + days + "<br>" +
                "<strong>Use By:</strong> <span class=\"use-by\">" + expires + "</span><br>" +
                "<strong>Location:</strong> " + location;
            document.getElementById("modal").classList.remove("hidden");
        });
    });
    document.getElementById("modal-close").addEventListener("click", () => {
        document.getElementById("modal").classList.add("hidden");
    });
    document.getElementById("filter").addEventListener("keyup", filterTable);
    document.querySelectorAll(".select-on-focus").forEach(input => {
        input.addEventListener("focus", function () {
            this.select();
        });
    });
    updateUseBy();
</script>
</body>
</html>