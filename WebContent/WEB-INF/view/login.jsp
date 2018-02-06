<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<h2>Please login</h2>

<c:if test="${loggedIn == false}">
	<p>Username and password combination incorrect. Please try again.</p>
</c:if>

<h3>${message}</h3>

<form action="LoginServlet?action=login" method="post">

	<p>Username</p>
	<p>
	<input type="text" name="username" required>
	</p>
	
	<p>Password</p>
	<p>
	<input type="password" name="password" required> 
	</p>
	
	<p>
	<a href="LoginServlet?action=showCreateNewUserForm">Create New User</a>
	</p>
	
	<p><input type="submit" value="Login"></p>

</form>

</body>
</html>