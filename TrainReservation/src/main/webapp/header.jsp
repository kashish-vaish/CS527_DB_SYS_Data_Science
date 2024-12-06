<!-- header.jsp -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutgers Train System</title>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        .banner {
            background-color: #0056b3;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .navbar {
            margin-top: 10px;
        }
        .navbar-nav .nav-link {
            color: #0056b3 !important;
        }
        .navbar-nav .nav-link:hover {
            color: #003366 !important;
        }
    </style>
</head>
<body>


    <div class="banner">
        <h1>Rutgers Train System</h1>
    </div>


    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
  <!--           <a class="navbar-brand" href="#">CS527 Group 7</a> -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="search.jsp">Search</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="reserve.jsp">Reserve</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</body>
</html>
