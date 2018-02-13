<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View All Links</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 

</head>
<body >
<div id="home">
<nav>
<div class="topnav" id="myTopnav">
  <a href="" class="active">S C</a>
  <a href="displayProduct.jsp">Ingredients</a>
  <a href="searchRecipes.jsp">Recipes</a>
  <a href="viewShoppingList.jsp">Shopping list</a>
  <a href="mealPlanner.jsp">Meal plans</a>
  <a href="eatingHealthy.jsp">Eating healthy</a>
  <a href="#contact">Contact</a>
  <a href="#about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>
 <h1 id= "heading1">Something about the app</h1>
 </div> <!-- end of home -->
<main>
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
		<a href="LoginServlet?action=logout">Logout</a>	
	</c:when>
	<c:otherwise>
		<a href="LoginServlet?action=showLoginForm">Login</a>	
	</c:otherwise>
</c:choose>
</div>


<div class ="mainpage one">
<a href = "">Ingredients</a>
</div>
<div class ="mainpage two">
<a href = "">Recipes</a>
</div>
<div class ="mainpage three">
<a href = "">Shopping List</a>
</div>
<div class ="mainpage four">
<a href = "">Meal Plans</a>
</div>
<div class ="five">
<a href = "">Eating Healthy</a>
</div>


<div class="searchLink">
<c:choose>
	<c:when test="${listOfProducts.isEmpty()}">
		<h2>No items match the search</h2>
	</c:when>
</c:choose>

<form action="BookServlet?action=searchForProduct" method="post">
	<input type="text" name="searchText" placeholder="Search"  class = "search">	
</form>
</div>
</main>
<div id="aboutcontact" class = "clearfix">
<div id = "about">

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
</div> <!-- end aboutcontact -->
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
<script type="text/javascript">

    var divHeight = document.getElementById('home').offsetHeight;
    var w = window.innerWidth;
    var h = window.innerHeight;

      
document.getElementById('home').style.height = h+"px";
document.getElementById('heading1').style.paddingTop = h/3 + "px";
</script>
</body>
</html>