<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/app.js"></script>
<link rel="stylesheet" href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>Events-Login Page</title>
</head>
<body>	
	<div class = "container">
		<div class="row mt-3">
			<div class="col">
			<p class="text-warning"><c:out value="${force}" /></p>
			<h1>Login</h1>
    			<p class="text-danger"><c:out value="${error}" /></p>
    			<form method="post" action="/login">
        		<p>
            		<label for="email">Email</label>
            		<input type="text" id="email" name="email"/>
        		</p>
        		<p>
            		<label for="password">Password</label>
            		<input type="password" id="password" name="password"/>
        		</p>
        		<input class="btn btn-success mb-3" type="submit" value="Login"/>
    			</form> 
    			<a href="/registration">Register Here</a>
			</div>
		</div>
	</div>
</body>
</html>