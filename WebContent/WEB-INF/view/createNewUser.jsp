<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New User</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<h2>New User - Enter Details</h2>

${message}

<form action="LoginServlet?action=createNewUser" method="post">

<p>Username</p>
<p><input type="text" name="username" required></p>

<p>Password</p>
<p><input type="password" name="password1" required> </p>

<p>Confirm</p>
<p><input type="password" name="password2" required> </p>

<p><input type="submit" value="Create new user"></p>

</form>

<nav>
<div class="topnav" id="myTopnav">
  <a href="#home" class="active">Home</a>
  <a href="#news">Ingredients</a>
  <a href="#contact">Recipes</a>
  <a href="#about">Shopping list</a>
  <a href="index.jsp">Meal plans</a>
  <a href="cre.jsp">Eating healthy</a>
  <a href="#contact">Contact</a>
  <a href="#about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>


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
</main>
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