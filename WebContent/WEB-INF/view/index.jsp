<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View All Books</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<h2>View All Books</h2>

<c:if test="${cart != null && !cart.isEmpty()}">

	<c:forEach var="item" items="${cart}">
		<c:set var="count" value="${count + item.value}"></c:set>
	</c:forEach>

	<a href="BookServlet?action=viewCart">View shopping cart: ${count} item(s)</a>
</c:if>
<!-- changes -->

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
	<c:when test="${listOfBooks.isEmpty()}">
		<h2>No books match the search</h2>
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
<a href="ProductServlet?action=showInsertForm">Insert New Book</a>
</p>
<p>
<a href="ProductServlet?action=showSearchForm">Search</a>
</p>
</body>
</html>