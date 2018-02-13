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
  <a href="ProductServlet?action=viewAll" class="active">C S</a>
  <a href="ProductServlet?action=displayProduct">Ingredients</a>
  <a href="ProductServlet?action=showSearchForm">Recipes</a>
  <a href="ProductServlet?action=viewCart">Shopping list</a>
  <a href="ProductServlet?action=mealPlanner">Meal plans</a>
  <a href="ProductServlet?action=eatingHealthy">Eating healthy</a>
  <a href="#contact">Contact</a>
  <a href="#about">About</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</nav>
 <h1 id= "heading1">Something about the app</h1>
 </div> <!-- end of home -->
<main>
<c:if test="${cart != null && !cart.isEmpty()}">


</body>
</html>