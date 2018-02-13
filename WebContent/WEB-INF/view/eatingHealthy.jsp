<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Eating Healthy</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<nav>
<div class="topnav" id="myTopnav">
  <a href="ProductServlet?action=viewAll">OurApp</a>
  <a href="ProductServlet?action=displayProduct">Ingredients</a>
  <a href="ProductServlet?action=showSearchForm">Recipes</a>
  <a href="ProductServlet?action=viewCart">Shopping list</a>
  <a href="ProductServlet?action=mealPlanner">Meal plans</a>
  <a href="ProductServlet?action=eatingHealthy" class="active">Eating healthy</a>
  <a href="ProductServlet?action=contact">Contact</a>
  <a href="ProductServlet?action=about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>

<main>
<h1>Eating Healthy Page....</h1>
<h2>in production.......</h2>

</main><!-- end of main -->

<footer>
<p>@copyright Aga&Gabi 2018</p>
</footer>

<script type="text/javascript">
/* Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon */
function myFunction() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
    } else {
        x.className = "topnav";
    }
}
</script>
</body>
</html>