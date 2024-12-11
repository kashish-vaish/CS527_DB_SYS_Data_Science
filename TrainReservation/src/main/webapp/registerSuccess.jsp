<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Registration Successful</title>

   <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

   <!-- Google Fonts -->
   <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@400;500&display=swap" rel="stylesheet">

   <!-- Custom CSS -->
   <link href="css/styles.css" rel="stylesheet">

</head>
<body>

    <%@ include file="header.jsp" %>

    <!-- Success Message Container -->
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg">
                    <div class="card-body text-center">
                        <h1 class="display-4 text-success">Congratulations!</h1>
                        <p class="lead">Registration was successful.</p>
                        <p>Please <a href="login.jsp" class="btn btn-primary">return to the login page</a> to sign in and access the system.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include the footer -->
    <%@ include file="footer.jsp" %>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
