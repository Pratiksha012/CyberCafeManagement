<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Browser</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        .search-container {
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .result-item {
            background-color: #fff;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <h1>Search Browser</h1>
    <div class="search-container">
        <form action="SearchServlet" method="get">
            <input type="text" name="query" placeholder="Enter search term..." required>
            <input type="submit" value="Search">
        </form>
    </div>

    <!-- Display search results if they exist -->
    <c:if test="${not empty results}">
        <h2>Search Results:</h2>
        <c:forEach var="result" items="${results}">
            <div class="result-item">
                <strong>${result.title}</strong><br>
                <p>${result.description}</p>
            </div>
        </c:forEach>
    </c:if>

    <c:if test="${empty results}">
        <p>No results found for your search.</p>
    </c:if>
</body>
</html>
