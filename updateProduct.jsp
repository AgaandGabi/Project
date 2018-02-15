<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Product</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<nav>
<div class="topnav" id="myTopnav">
  <a href="ProductServlet?action=viewAll">OurApp</a>
  <a href="ProductServlet?action=displayProduct" class="active">Ingredients</a>
  <a href="ProductServlet?action=showSearchForm">Recipes</a>
  <a href="ProductServlet?action=viewCart">Shopping list</a>
  <a href="ProductServlet?action=mealPlanner">Meal plans</a>
  <a href="ProductServlet?action=eatingHealthy">Eating healthy</a>
  <a href="ProductServlet?action=contact">Contact</a>
  <a href="ProductServlet?action=about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>

<main>
<h1>updateProduct.jsp</h1>
<h2>Updating ${product.name}</h2>

<form action="ProductServlet?action=updateProduct" method="post">
	<input type="hidden" name="productId" value="${product.id}">
	
	<p>Name:</p> 
	<p><input type="text" name="name" value="${product.name}" size="49"></p> 
	
	<p>Quantity:</p> 
	<p><input type="text" name="quantity" value="${product.quantity}" size="49"></p> 
	
	<p>Weight:</p> 
	<p><input type="text" name="weight" value="${product.weight}" size="49"></p> 
	
	<p>Description:</p> 
	<p><textarea rows="5" cols="50" name="description">${product.description}</textarea></p> 

	<p>Price:</p> 
	<p><input type="text" name="price" 
			 value="<fmt:formatNumber type='number'
			 maxFractionDigits='2' value='${product.price}'>
			 </fmt:formatNumber>"></input></p>
	 
	<p><input type="submit" value="Submit"/></p> 
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