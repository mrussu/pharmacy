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
    <title>Pharmacy | XR2 Tray Guide</title>
    <style>
        @media print {
            * {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
            .container {
                width: 100%;
                max-width: 100%;
            }
            .menu {
                display: none !important;
            }
            .tray-label {
                box-shadow: none;
            }
            @page {
                size: landscape;
                margin: 1cm;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="menu light">
        <a href="/pharmacy">Pharmacy Tools</a>
    </div>
    <h1>XR2 Tray Guide</h1>
    <table class="tray-guide-table">
        <thead>
        <tr>
            <th class="column-label">Type <span class="hint">Slots</span></th>
            <th class="column-dimensions">Dimensions <span class="hint">(Cols x Rows)</span></th>
            <th class="column-cells">Cells</th>
        </tr>
        </thead>
        <tbody>
        <#list trays as tray>
            <tr>
                <td class="column-label"><div class="tray-label nowrap" style="background-color:<#if tray.color??>${tray.color}<#else>inherit</#if>">${tray.type} <span>${tray.slots}</span></div></td>
                <td class="column-dimensions"><span class="nowrap">${tray.cols} × ${tray.rows}</span></td>
                <td class="column-cells"><span>${tray.cells}</span></td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>
</body>
</html>