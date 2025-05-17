<!doctype html>
<html dir="ltr" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <link rel="stylesheet" href="/pharmacy/static/css/styles.css" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <title>Pharmacy | Use By Date Calculator</title>
</head>
<body>
<div class="container">
    <div class="menu light">
        <a href="/pharmacy">Pharmacy Tools</a>
    </div>
    <h1>Use By Date Calculator</h1>
    <p class="today-date">Today: ${today}</p>
    <table>
        <thead>
        <tr>
            <th>Days Left</th>
            <th>Use By</th>
        </tr>
        </thead>
        <tr>
            <td><input type="number" id="daysLeft" class="select-on-focus" placeholder="Days Left" value="28" min="1" max="365" /></td>
            <td class="column-use-by"><span id="useBy" class="use-by"></span></td>
        </tr>
    </table>
</div>
<script>
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
    document.querySelectorAll(".select-on-focus").forEach(input => {
        input.addEventListener("focus", function () {
            this.select();
        });
    });
    updateUseBy();
</script>
</body>
</html>