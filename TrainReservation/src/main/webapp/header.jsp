<!-- header.jsp -->
<div class="banner">
    <h1>Rutgers Train System</h1>
    <h2>Group 7</h2>
</div>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="reserve.jsp">Reserve</a>
                </li>
            </ul>
            <!-- Add a flex container to push the username and logout to the right -->
            <ul class="navbar-nav ms-auto"> <!-- ms-auto is equivalent to ml-auto in Bootstrap 5 -->
                <% 
                    String user = (String) session.getAttribute("user"); 
                    if (user != null) {
                %>
                    <li class="nav-item">
                        <span class="nav-link">Welcome, <%= user %>!</span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">Logout</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
