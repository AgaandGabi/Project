<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>About</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<nav>
<div class="topnav" id="myTopnav">
  <a href="index.jsp">Soap</a>
  <a href="displayProduct.jsp">Ingredients</a>
  <a href="searchRecipes.jsp">Recipes</a>
  <a href="viewShoppingList.jsp">Shopping list</a>
  <a href="mealPlanner.jsp">Meal plans</a>
  <a href="eatingHealthy.jsp">Eating healthy</a>
  <a href="contact.jsp">Contact</a>
  <a href="about.jsp" class="active">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>

<main>
<h1>About Page....</h1>
<h2>in production....</h2>

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