<!DOCTYPE html>
<html lang="en">
<head>
    <title>Schedule</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../src/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e0e6ec;
            font-family: 'Noto Sans JP', sans-serif;
        }

        p, ul > li > span {
            color: #515151;
        }

        #top {
            width: 400px;
            height: 130px;
            margin: 15px;
            border-radius: 20px;
            background: #e0e6ec;
            box-shadow: 7px 7px 14px #bec4c9,
            -7px -7px 14px #ffffff;
            position: absolute;
        }

        #top > p {
            margin-top: 10px;
            margin-left: 15px;
            position: relative;
        }

        #top > ul {
            margin-top: 10px;
            position: relative;
        }
    </style>
</head>
<body>

<div id="top">
    <!--        <p>{{ date }}の予定</p>-->
    <ul>
        {% for event in events %}
        <li style="color: {{ event.color }}">
            <span {% if event.end %} style="text-decoration: line-through;" {% endif %}>{{ event.date }} {{ event.summary }}</span>
        </li>
        {% endfor %}
    </ul>
</div>

</body>
</html>
