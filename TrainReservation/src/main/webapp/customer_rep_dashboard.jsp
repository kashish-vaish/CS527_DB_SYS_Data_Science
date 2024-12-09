<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Representative Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
    </style>
</head>
<body>
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
            <div class="card"> ️
            <div class="card-icon">🚄</div>
        
                
                <div class="card-title">Customer Reservations</div>
                <button onclick="window.location.href='customer_rep_reservation _by_line _and _date.jsp'">View Reservations</button> 
            </div>
        </div>
    </div>
</body>
</html>



