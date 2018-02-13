<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Shopping List</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<nav>
<div class="topnav" id="myTopnav">
  <a href="ProductServlet?action=viewAll">OurApp</a>
  <a href="ProductServlet?action=displayProduct">Ingredients</a>
  <a href="ProductServlet?action=showSearchForm">Recipes</a>
  <a href="ProductServlet?action=viewCart" class="active">Shopping list</a>
  <a href="ProductServlet?action=mealPlanner">Meal plans</a>
  <a href="ProductServlet?action=eatingHealthy">Eating healthy</a>
  <a href="ProductServlet?action=contact">Contact</a>
  <a href="ProductServlet?action=about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>

<main>
<h1>viewShoppingList.jsp</h1>
<h2>View Shopping Cart</h2>

<table>
	<tr><th>Id</th>
		<th>Title</th>
		<th>Author</th>
		<th>Description</th>
		<th>Price</th>
		<th>Quantity</th>
		<th>Change Quantity</th>
		<th>Total</th>
	</tr>
	<!-- We are looping through the shopping cart, it is a map and a 
	map contains key value pairs, the key is the book and the value
	is the quantity ordered for each book. As this loop iterated through
	the cart, each element can be accessed via the "item" variable,
	'item.key' will access the book and 'item.value' will access the
	quantity.  -->
	<c:forEach var="item" items="${cart}">
		<tr>
			<td>${item.key.id}</td>
			<td>${item.key.title}</td>
			<td>${item.key.author}</td>
			<td>${item.key.description}</td>
			<td>&euro;<fmt:formatNumber type="number"
			 maxFractionDigits="2" value="${item.key.price}" /></td>
			<td>${item.value}</td>
			<td>
			<a href="ProductServlet?action=addQuantityToCart&productId=${item.key.id}">Add</a> 
			<a href="ProductServlet?action=removeQuantityFromCart&productId=${item.key.id}">Remove</a></td>
			<td>${item.key.price * item.value}</td>
			<!-- Sets up a total variable and each time through the loop
			the price multiplied by the quantity is added to the total. -->
			<c:set var="total" value="${total + item.key.price * item.value}" /> 
		</tr>
	</c:forEach>
</table>
<p>
<!-- Display the total from the variable declared in the for loop -->
Total cost : &euro;${total}
</p>
<p><a href="ProductServlet?action=viewAll">View Products</a></p>
<p><a href="ProductServlet?action=clearCart">Clear Shopping Cart</a></p>



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