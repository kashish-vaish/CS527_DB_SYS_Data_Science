<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer FAQ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .faq-item {
            border: 1px solid #ccc;
            margin-bottom: 10px;
            border-radius: 5px;
            background-color: #fff;
        }
        .faq-question {
            cursor: pointer;
            padding: 15px;
            font-size: 16px;
            background-color: #f1f1f1;
            border-radius: 5px 5px 0 0;
        }
        .faq-answer {
            display: none;
            padding: 15px;
            border-top: 1px solid #ccc;
        }
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-container input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-container button {
            padding: 10px 20px;
            border: none;
            background-color: #007BFF;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        .submit-question-container {
            text-align: center;
            margin-top: 30px;
        }
        .submit-question-container button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
    <script>
        // JavaScript to toggle FAQ answer visibility
        function toggleAnswer(id) {
            const answer = document.getElementById('answer-' + id);
            if (answer.style.display === 'none' || answer.style.display === '') {
                answer.style.display = 'block';
            } else {
                answer.style.display = 'none';
            }
        }
    </script>
</head>
<body>
    <h1>Frequently Asked Questions</h1>

    <div class="faq-container">
        <div class="search-container">
            <form method="GET">
                <input type="text" name="keyword" placeholder="Search questions..." 
                       value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                <button type="submit">Search</button>
            </form>
        </div>

        <%
            String keyword = request.getParameter("keyword");
            ApplicationDB db = new ApplicationDB();
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int count = 1; // Start numbering for the questions

            try {
                conn = db.getConnection();
                String query = "SELECT id, question, answer FROM customer_questions " +
                               "WHERE question LIKE ? OR answer LIKE ? " +
                               "ORDER BY created_at DESC " +
                               "LIMIT 30"; // Restrict to 30 questions
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, "%" + (keyword != null ? keyword : "") + "%");
                pstmt.setString(2, "%" + (keyword != null ? keyword : "") + "%");
                rs = pstmt.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                <p style="text-align: center; color: red;">No questions found for the given search criteria.</p>
        <%
                } else {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String question = rs.getString("question");
                        String answer = rs.getString("answer");
        %>
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleAnswer(<%= id %>)">
                        <%= count++ %>. Q: <%= question %>
                    </div>
                    <div class="faq-answer" id="answer-<%= id %>">
                        A: <%= (answer != null ? answer : "No answer yet.") %>
                    </div>
                </div>
        <%
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color: red;'>Error loading questions: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) db.closeConnection(conn);
            }
        %>
    </div>

    <div class="submit-question-container">
        <form method="POST">
            <textarea name="question" rows="5" cols="50" placeholder="Type your question here..." required></textarea><br><br>
            <button type="submit">Submit a Question</button>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String question = request.getParameter("question");

                try {
                    conn = db.getConnection();
                    String insertQuery = "INSERT INTO customer_questions (question) VALUES (?)";
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, question);
                    pstmt.executeUpdate();
                    out.println("<p style='color: green;'>Your question has been submitted successfully!</p>");
                } catch (SQLException e) {
                    out.println("<p style='color: red;'>Error submitting your question: " + e.getMessage() + "</p>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) db.closeConnection(conn);
                }
            }
        %>
    </div>
</body>
</html>


