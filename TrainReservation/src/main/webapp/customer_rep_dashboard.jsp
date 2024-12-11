<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Representative Dashboard</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/styles.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
            padding-bottom: 100px; /* Prevent footer overlap */
        }

        .dashboard-container {
            text-align: center;
            max-width: 900px;
            margin: auto;
        }

        .dashboard-title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }

        .card-icon {
            font-size: 3rem;
            color: #007bff;
            margin-bottom: 10px;
        }

        .card-title {
            font-size: 1.25rem;
            color: #333;
            margin-bottom: 10px;
        }

        .card button {
            padding: 10px 15px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }

        .card button:hover {
            background-color: #0056b3;
        }

        footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 10px 0;
            z-index: 1000; /* Ensure footer stays on top */
        }
    </style>

</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="dashboard-container">
        <h1 class="dashboard-title">Customer Representative Dashboard</h1>

        <div class="grid">
            <!-- Edit and Delete Train Schedules -->
            <div class="card">
                <div class="card-icon">✏️</div>
                <div class="card-title">Edit & Delete Train Schedules</div>
                <button onclick="window.location.href='customer_rep_update.jsp'">Manage Schedules</button>
            </div>

            <!-- Reply to Customer Questions -->
            <div class="card">
                <div class="card-icon">💬</div>
                <div class="card-title">Reply to Customer Questions</div>
                <button onclick="window.location.href='customer_rep_reply_question.jsp'">Reply Questions</button>
            </div>

            <!-- Train Schedules by Station -->
            <div class="card">
                <div class="card-icon">📅</div>
                <div class="card-title">Train Schedules by Station</div>
                <button onclick="window.location.href='customer_rep_station_schedule.jsp'">View Schedules</button>
            </div>

            <!-- Customer Reservations by Line and Date -->
            <div class="card">
                <div class="card-icon">🚄</div>
                <div class="card-title">Customer Reservations</div>
                <button onclick="window.location.href='customer_rep_reservation_by_line_and_date.jsp'">View Reservations</button>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
