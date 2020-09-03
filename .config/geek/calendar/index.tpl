<!DOCTYPE html>
<html lang="ja">
<head>
    <title>Calendar</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../src/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e0e6ec;
            font-family: 'Noto Sans JP', sans-serif;
        }

        #top {
            width: 500px;
            margin: 15px;
        }

        #top > div:not(:last-child) {
            margin-bottom: 20px;
        }

        #top > div > div > div {
            width: 40px;
            height: 40px;
            margin: 0 auto;
            border-radius: 20px;
            background-color: #e0e6ec;
            box-shadow: 7px 7px 10px #bec4c9,
            -7px -7px 10px #ffffff;
        }

        #top > div > div > div.today {
            box-shadow: inset 5px 5px 5px #bec4c9,
            inset -5px -5px 5px #ffffff;
        }

        #top > div > div > div > p {
            color: #515151;
            line-height: 40px;
        }
    </style>
</head>
<body>

<div id="top" class="container-fluid text-center">
    {% for week in days %}
    <div class="row">
        {% for day in week %}
        {% if day['today'] %}
        <div class="col">
            <div class="today"><p>{{ day['day'] }}</p></div>
        </div>
        {% elif day['day'] != 0 %}
        <div class="col">
            <div><p>{{ day['day'] }}</p></div>
        </div>
        {% else %}
        <div class="col"></div>
        {% endif %}
        {% endfor %}
    </div>
    {% endfor %}
</div>

</body>
</html>