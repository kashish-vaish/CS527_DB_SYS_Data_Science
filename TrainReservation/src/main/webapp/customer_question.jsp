<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer FAQ</title>

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
            padding-bottom: 100px; /* Add extra padding to prevent footer overlap */
        }

        .faq-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .faq-item {
            margin-bottom: 15px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .faq-question {
            cursor: pointer;
            padding: 15px;
            background-color: #f1f1f1;
            border-radius: 5px 5px 0 0;
            font-size: 16px;
        }

        .faq-answer {
            display: none;
            padding: 15px;
            border-top: 1px solid #ddd;
        }

        .search-container {
            text-align: center;
            margin-bottom: 30px;
        }

        .search-container input[type="text"] {
            width: 300px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
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
            padding-bottom: 30px; /* Add padding to make sure it's not hidden */
        }

        .submit-question-container button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border-radius: 5px;
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
            z-index: 1000; /* Ensure footer stays on top of other content */
        }
    </style>

    <script>
        // Toggle visibility of the FAQ answers
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

    <%@ include file="header.jsp" %>

    <h1 class="text-center">Frequently Asked Questions</h1>

    <div class="faq-container">

        <!-- Search bar -->
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
            int count = 1; // Numbering for the questions

            try {
                conn = db.getConnection();
                String query = "SELECT id, question, answer FROM customer_questions " +
                               "WHERE question LIKE ? OR answer LIKE ? " +
                               "ORDER BY created_at DESC " +
                               "LIMIT 30"; // Limit the results to 30 questions
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, "%" + (keyword != null ? keyword : "") + "%");
                pstmt.setString(2, "%" + (keyword != null ? keyword : "") + "%");
                rs = pstmt.executeQuery();

                if (!rs.isBeforeFirst()) {
        %>
                <p class="text-center text-danger">No questions found for the given search criteria.</p>
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
                out.println("<p class='text-danger'>Error loading questions: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) db.closeConnection(conn);
            }
        %>
    </div>

    <!-- Submit a Question Section -->
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
                    out.println("<p class='text-center text-success'>Your question has been submitted successfully!</p>");
                } catch (SQLException e) {
                    out.println("<p class='text-center text-danger'>Error submitting your question: " + e.getMessage() + "</p>");
                } finally {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) db.closeConnection(conn);
                }
            }
        %>
    </div>

    <%@ include file="footer.jsp" %>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
