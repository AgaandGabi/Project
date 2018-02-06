<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Product</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

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
</body>
</html>