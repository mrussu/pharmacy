<!doctype html>
<html dir="ltr" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/pharmacy/static/css/styles.css" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <title>Pharmacy</title>
</head>
<body>
<div class="container">
    <h1>Tools</h1>
    <ul class="menu">
        <#list menu as item>
            <li><a href="/pharmacy/${item.href}">${item.name}</a></li>
        </#list>
    </ul>
</div>
</body>
</html>