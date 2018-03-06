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
<div id="home">
<nav>
<div class="topnav" id="myTopnav">
  <a href="ProductServlet?action=indexpage" class="active">C S</a>
  <a href="ProductServlet?action=viewall">Ingredients</a>
  <a href="ProductServlet?action=showSearchForm">Recipes</a>
  <a href="ProductServlet?action=viewCart">Shopping list</a>
  <a href="ProductServlet?action=mealPlanner">Meal plans</a>
  <a href="ProductServlet?action=eatingHealthy">Eating healthy</a>
  <a href="#contact">Contact</a>
  <a href="#about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>
 </div><!-- end of home -->
<main>
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


<div class="searchLink">
<c:choose>
	<c:when test="${listOfProducts.isEmpty()}">
		<h2>No items match the search</h2>
	</c:when>
</c:choose>
<form action="ProductServlet?action=searchForProduct" method="post">
	<input type="text" name="searchText" placeholder="Search"  class = "search">	
</form>
</div><!-- end searchLinks -->

<div class="loginLinks">
<!-- When the 'username' attribute is not null, somebody is logged
     in. Otherwise display a 'login' link. -->
<c:choose>
	<c:when test="${username != null}">
		${username} is logged in.
		<a href="LoginServlet?action=logout">Logout</a>	
	</c:when>
	<c:otherwise>
		<a href="LoginServlet?action=showLoginForm">Login</a>	
	</c:otherwise>
</c:choose>
</div><!-- end loginLinks -->


</main><!-- end of main -->


<div id="aboutcontact" class = "clearfix">
<div id = "about">
<p>There is a lot to be gained by planning your meals: you <strong>eat better</strong>, healthier food, <strong>do more cooking</strong> and put more thought into what you eat, try new recipes, and save at the grocery store at the same time.</p> 
<p><strong>Cook Smart </strong> has a good collection of recipes that you can use to build menus for your regular meals, for special events, or any night of the week.</p> 
<p><strong>Cook Smart</strong> can also generate a shopping list based on your meal plan that you can take with you and cross off at the grocery store. You can share your recipes, meal plans, or shopping lists with others if you need to. When you are ready to cook, <strong>Cook Smart</strong> will walk you through the recipes, complete with cooking timers to help you stay on top of simmering or baking food.</p>

</div>

<div id = "contact" class = "clearfix">
<h2>Help us improve our services</h2>
<form action="ProductServlet?action=contactForm" method="post">
	
	<input type="text" name="name"  class="input" placeholder="name" required >

	<input type="email" name="email"  class="input" placeholder="e-mail address" required>
	
	<textarea  name="comments" 
	    placeholder="comments"></textarea>
	<input type="submit" value="Submit" class="submit">
</form>
</div> <!-- end contact -->

<footer>
<p>@copyright Aga&#38;Gabi 2018</p>
</footer>
</div> <!-- end aboutcontact -->
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
<script type="text/javascript">
    var divHeight = document.getElementById('home').offsetHeight;
    var w = window.innerWidth;
    var h = window.innerHeight;      
document.getElementById('home').style.height = h+"px";
document.getElementById('heading1').style.paddingTop = h/1.8 + "px";
</script>
</body>
</html>