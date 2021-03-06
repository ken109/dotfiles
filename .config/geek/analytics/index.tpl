<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Analytics</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../src/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e0e6ec;
            font-family: 'Noto Sans JP', sans-serif;
        }

        #top {
            width: 600px;
            margin: 15px;
            border-radius: 20px;
            background: #e0e6ec;
            box-shadow: 7px 7px 14px #bec4c9,
            -7px -7px 14px #ffffff;
            position: absolute;
        }

        #top > canvas {
            position: relative;
            padding: 10px;
            border-radius: 20px;
        }
    </style>
</head>
<body>

<div id="top">
    <canvas id="analytics" style="background-color: #e0e6ec"></canvas>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<script>
    let data = JSON.parse('{{ json }}');

    let ctx = document.getElementById("analytics");
    let analytics = new Chart(ctx, {
        type: 'line',
        data: {
            labels: data['days'],
            datasets: [
                {
                    label: 'Users',
                    data: data['values'],
                    borderColor: "rgba(82,81,81,1)",
                    backgroundColor: "rgba(0,0,0,0)",
                    lineTension: 0
                },
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    display: true,
                    ticks: {
                        max: Math.ceil((data['max'] + 5) / 10) * 10
                    }
                }]
            },
            animation: {
                duration: 0
            }
        }
    });
</script>
</body>
</html>