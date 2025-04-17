<!doctype html>
<html dir="ltr" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/static/css/styles.css" form="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <title>Use By Dates</title>
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
            <td><input type="number" id="daysLeft" placeholder="Days Left" value="28" min="1" max="365" /></td>
            <td>${today}</td>
            <td><span id="useBy" class="expires-date"></span></td>
        </tr>
    </table>
    <h1>Medication Use By Dates</h1>
    <table class="use-by-table">
        <thead>
            <tr>
                <th><input type="text" id="filterInput" onkeyup="filterTable()" placeholder="Filter by name" /></th>
                <th>Form</th>
                <th>Days</th>
                <th>Use By</th>
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
                <td>${med.name}</td>
                <td>${med.form}</td>
                <td>${med.useByDays}</td>
                <td><span class="expires-date">${med.useBy}</span></td>
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
        const input = document.getElementById("filterInput").value.toLowerCase();
        const rows = document.querySelectorAll(".use-by-table tbody tr");
        rows.forEach(row => {
            const name = row.cells[0].innerText.toLowerCase();
            row.style.display = name.includes(input) ? "" : "none";
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
            const form = row.dataset.form;
            const days = row.dataset.days;
            const expires = row.dataset.expires;
            const location = row.dataset.location || '–';

            document.getElementById("modal-title").innerHTML = name;
            document.getElementById("modal-body").innerHTML =
                "<strong>Form:</strong> " + form + "<br>" +
                "<strong>Days:</strong> " + days + "<br>" +
                "<strong>Use By:</strong> <span class=\"expires-date\">" + expires + "</span><br>" +
                "<strong>Location:</strong> " + location;
            document.getElementById("modal").classList.remove("hidden");
        });
    });
    document.getElementById("modal-close").addEventListener("click", () => {
        document.getElementById("modal").classList.add("hidden");
    });
    updateUseBy();
</script>
</body>
</html>