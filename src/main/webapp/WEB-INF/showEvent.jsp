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
<title><c:out value="${event.name}"/></title>
</head>
<body>
	<div class="container">
		<div class="row">
		<div class="col">
			<h1 class="mt-5"><c:out value="${event.name}"/></h1>
			<p>Host: <c:out value="${event.host.firstName}"/> <c:out value="${event.host.lastName}"/> </p>
			<p>Date: <c:out value="${event.date}"/> </p>
			<p>Location: <c:out value="${event.location}"/> </p>
			<p>People who are attending this event: <c:out value="${currentGuests}"/> </p>
			<table class="table mt-5">
			  <thead class="thead-dark">
			    <tr>
			      <th scope="col">Name</th>
			      <th scope="col">Location</th>
			    </tr>
			  </thead>
			  <tbody>
				  <c:forEach items="${event.guests}" var="guest">
				    <tr>
				      <td><c:out value="${guest.firstName}"/> <c:out value="${guest.lastName}"/></td>
				      <td><c:out value="${guest.location}"/></td>
				    </tr>
				  </c:forEach>
			  </tbody>
			</table>
		</div>
		<div class="col">
		<a class= "btn btn-primary float-right mt-3" href="/events">Back to Events</a>
			<h3 class="mt-5">Message Wall</h3>
			<div>
				<textarea cols="40" rows="10" id="comment" name="comment">
<c:forEach items="${event.comments}" var="comment">
	<c:out value="${comment.postedBy.firstName}"/> <c:out value="${comment.postedBy.lastName}"/>: <c:out value="${comment.content}"/>
	
	********************
</c:forEach>
				</textarea>
			</div>
			<div>
				<form:form class="form-group mt-3" method="post" action="/addComment/${event.id}" modelAttribute="comment">
	    			<form:hidden value="${userId}" path="postedBy"/>
		    		<p>
		            	<form:label path="content">Add a Comment:</form:label><br>
		            	<form:textarea path="content" type="text" cols="40" rows="3"/>
		            	<form:errors path="content" class="text-danger"/>
		        	</p>
					<input type="submit" value="Add Comment" class="btn btn-sm btn-primary mt-3"/>
				</form:form>
			</div>
		</div>
		</div>
	</div>
</body>
</html>