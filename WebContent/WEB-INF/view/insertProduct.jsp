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

<!--start of insertProduct -->

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