<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Random"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%
    // Initialize session
    HttpSession usersession = request.getSession();
    
    // Initialize the random number generator
    Random rand = new Random();
    
    // Check if the game has started
    if (session.getAttribute("randomNumber") == null) {
        // Generate a new random number between 1 and 100
        int randomNumber = rand.nextInt(100) + 1;
        session.setAttribute("randomNumber", randomNumber);
        session.setAttribute("attempts", 0); // Initialize attempts
    }

    // Get the random number from session
    int randomNumber = (Integer) session.getAttribute("randomNumber");
    int attempts = (Integer) session.getAttribute("attempts");

    String message = "";
    String userGuess = request.getParameter("guess");

    // Check if the user has made a guess
    if (userGuess != null) {
        int guess = Integer.parseInt(userGuess);
        attempts++;
        session.setAttribute("attempts", attempts);

        // Compare the guess to the random number
        if (guess < randomNumber) {
            message = "Your guess is too low!";
        } else if (guess > randomNumber) {
            message = "Your guess is too high!";
        } else {
            message = "Congratulations! You guessed the number in " + attempts + " attempts!";
            // Reset the game
            session.removeAttribute("randomNumber");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Number Guessing Game</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        input[type="number"] {
            padding: 5px;
            width: 50px;
        }
        input[type="submit"] {
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            margin-top: 10px;
            display: inline-block;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Guess the Number!</h1>
    <p>Guess a number between 1 and 100:</p>
    <form action="games.jsp" method="post">
        <input type="number" name="guess" min="1" max="100" required>
        <input type="submit" value="Submit Guess">
    </form>
    <p><%= message %></p>
    <a href="userDashboard.jsp" class="button">Home</a>
</body>
</html>
