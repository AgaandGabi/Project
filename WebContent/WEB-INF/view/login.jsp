<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<nav>
<div class="topnav" id="myTopnav">
  <a href="index.jsp" class="active">Soap</a>
  <a href="displayProduct.jsp">Ingredients</a>
  <a href="searchRecipes.jsp">Recipes</a>
  <a href="viewShoppingList.jsp">Shopping list</a>
  <a href="mealPlanner.jsp">Meal plans</a>
  <a href="eatingHealthy.jsp">Eating healthy</a>
  <a href="contact.jsp">Contact</a>
  <a href="about.jsp">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>

<main>
<h1>login.jsp</h1>
<h2>Please login</h2>

<c:if test="${loggedIn == false}">
	<p>Username and password combination incorrect. Please try again.</p>
</c:if>

<h3>${message}</h3>

<form action="LoginServlet?action=login" method="post">

	<p>Username</p>
	<p>
	<input type="text" name="username" required>
	</p>
	
	<p>Password</p>
	<p>
	<input type="password" name="password" required> 
	</p>
	
	<p>
	<a href="LoginServlet?action=showCreateNewUserForm">Create New User</a>
	</p>
	
	<p><input type="submit" value="Login"></p>

</form>

<c:if test="${cart != null && !cart.isEmpty()}">

	<c:forEach var="item" items="${cart}">
		<c:set var="count" value="${count + item.value}"></c:set>
	</c:forEach>

	<a href="ProductServlet?action=viewCart">View shopping list: ${count} item(s)</a>
</c:if>

<div class="loginLinks">
<!-- When the 'username' attribute is not null, somebody is logged
     in. Otherwise display a 'login' link. -->
<c:choose>
	<c:when test="${username != null}">
		${username} is logged in.
		<a href="LoginServlet?action=logout">logout</a>	
	</c:when>
	<c:otherwise>
		<a href="LoginServlet?action=showLoginForm">login</a>	
	</c:otherwise>
</c:choose>
</div>

<div class="searchLink">
<c:choose>
	<c:when test="${listOfProducts.isEmpty()}">
		<h2>No items match the search</h2>
	</c:when>
</c:choose>
<p>
<a href="ProductServlet?action=showSearchForm">Search</a>
</p>
</div>
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