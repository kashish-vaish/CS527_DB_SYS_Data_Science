<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.cs527.pkg.ApplicationDB" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reply to Customer Questions</title>
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
        .question-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .question-item {
            border: 1px solid #ccc;
            margin-bottom: 10px;
            border-radius: 5px;
            background-color: #fff;
            padding: 15px;
        }
        .highlight {
            border-color: #28a745;
            background-color: #eaffea;
        }
        .question-item h3 {
            margin: 0;
            color: #007bff;
        }
        .question-item p {
            margin: 10px 0;
            font-size: 14px;
            color: #333;
        }
        .reply-form textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .reply-form button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        .reply-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <button onclick="window.location.href='customer_rep_dashboard.jsp'" style="background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
        Back to Dashboard
    </button>
    <h1>Reply to Customer Questions</h1>

    <div class="question-container">
        <% 
            ApplicationDB db = new ApplicationDB();
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int updatedQuestionId = -1;

            // 处理 POST 请求
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String action = request.getParameter("action");
                if ("reply".equalsIgnoreCase(action)) {
                    int questionId = Integer.parseInt(request.getParameter("id"));
                    String reply = request.getParameter("reply");
                    try {
                        conn = db.getConnection();
                        String updateQuery = "UPDATE customer_questions SET answer = ?, answered_at = NOW() WHERE id = ?";
                        pstmt = conn.prepareStatement(updateQuery);
                        pstmt.setString(1, reply);
                        pstmt.setInt(2, questionId);
                        pstmt.executeUpdate();
                        updatedQuestionId = questionId;
                        out.println("<p style='color: green;'>Reply submitted successfully for Question ID: " + questionId + "</p>");
                    } catch (SQLException e) {
                        out.println("<p style='color: red;'>Error submitting reply: " + e.getMessage() + "</p>");
                    } finally {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) db.closeConnection(conn);
                    }
                }
            }

            // 查询所有问题
            try {
                conn = db.getConnection();
                String query = "SELECT id, question, answer, created_at, answered_at FROM customer_questions ORDER BY created_at DESC";
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String question = rs.getString("question");
                    String answer = rs.getString("answer");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    Timestamp answeredAt = rs.getTimestamp("answered_at");
        %>
        <div class="question-item <%= (id == updatedQuestionId) ? "highlight" : "" %>">
            <h3>Question ID: <%= id %></h3>
            <p><strong>Customer Question:</strong> <%= question %></p>
            <p><strong>Created At:</strong> <%= createdAt %></p>
            <p><strong>Current Answer:</strong> <%= (answer != null ? answer : "No answer yet.") %></p>
            <% if (answeredAt != null) { %>
                <p><strong>Answered At:</strong> <%= answeredAt %></p>
            <% } %>
            <!-- 回复表单 -->
            <form class="reply-form" method="POST">
                <textarea name="reply" rows="4" placeholder="Type your reply here..." required></textarea>
                <input type="hidden" name="id" value="<%= id %>">
                <input type="hidden" name="action" value="reply">
                <button type="submit">Submit Reply</button>
            </form>
        </div>
        <% 
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
</body>
</html>

