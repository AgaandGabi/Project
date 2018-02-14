<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Display Products</title>
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
<h1>displayProducts.jsp</h1>
<h2>Shopping list</h2>

	<c:forEach var="item" items="${cart}">
		<c:set var="count" value="${count + item.value}"></c:set>
	</c:forEach>

	<a href="ProductServlet?action=viewCart">View shopping list: ${count} item(s)</a>


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


<br><br>
<c:choose>
	<c:when test="${listOfProducts.isEmpty()}">
		<h2>No items match the search</h2>
	</c:when>
	
	<c:otherwise>
		<table>
			<tr><th>Id</th>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Weight</th>
				<th>Quantity</th>
				<th>Update</th>
				<th>Delete</th>
				<th>Add to Shopping list</th>
			</tr>
			<c:forEach var="product" items="${listOfProducts}" varStatus="status" >
				<tr>
					<td>${product.id}</td>
					<td>${product.name}</td>
					<td>${product.description}</td>
					<td>&euro;<fmt:formatNumber type="number"
					 maxFractionDigits="2" value="${product.price}" /></td>
					 	<td>${product.weight}</td>
					 		<td>${product.quantity}</td>
					 
					<td><a href="ProductServlet?action=showUpdateForm&productId=${product.id}">Update</a></td>
					<td><a href="ProductServlet?action=delete&productId=${product.id}">Delete</a></td>
					<td><a href="ProductServlet?action=addToCart&productId=${product.id}">Buy</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:otherwise>
</c:choose>
<p>
<a href="ProductServlet?action=showInsertForm">Insert New Product</a>
</p>
<p>
<a href="ProductServlet?action=showSearchForm">Search</a>
</p>


<!-- end of displayProduct -->


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