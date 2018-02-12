<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert Product</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<nav>
<div class="topnav" id="myTopnav">
  <a href="index.jsp">Soap</a>
  <a href="displayProduct.jsp" class="active">Ingredients</a>
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

<!--start of insertProduct -->

<h1>insertProduct.jsp</h1>
<h2>Insert Product details</h2>
<form action="ProductServlet?action=insertProduct" method="post">
	<p>Name</p>
	<p><input type="text" name="title" placeholder="title" required></p>
	<p>Description</p>
	<p><input type="text" name="author" placeholder="author" required></p>
	<p>Description</p>
	<p><textarea rows="4" cols="50" name="description" 
	    placeholder="description"></textarea></p>
	<p>Price</p>
	<p><input type="text" name="price" placeholder="price"></p>	
	
	<p><input type="submit" value="Insert"></p>
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