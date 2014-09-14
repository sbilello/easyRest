<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt"%>
<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<!DOCTYPE html>
<html>
<head>
<title><fmt:message key="welcome"/></title>
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
	<div class="container-fluid">
		<div class="jumbotron text-center">
			<div>
				<h1><fmt:message key="welcome"/></h1>
				<h2><fmt:message key="functions"/></h2>
				<ol>
					<li><fmt:message key="create.delete.developers"/></li>
					<li><fmt:message key="create.edit.stories"/></li>
					<li><fmt:message key="plan.your.stories"/></li>
					<li><a class="btn" href="${baseUrl}/index.htm?language=en">English</a></li>
					<li><a class="btn" href="${baseUrl}/index.htm?language=it">Italian</a></li>
				</ol>
			</div>
			<a class="btn btn-primary" href="${baseUrl}/developer/create.htm"> <fmt:message key="developer"/> </a>
			<a class="btn btn-primary" href="${baseUrl}/story/create.htm"> <fmt:message key="story"/> </a>
			<a class="btn btn-primary" href="${baseUrl}/story/plan.htm"> <fmt:message key="plan"/> </a>
		</div>
	</div>
</body>
</html>
