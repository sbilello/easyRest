<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt" %>

<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="developer.title"/></title>
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<body>
   <div class="container-fluid">
	 <div class="hero-unit text-center">
        <div>
           <h1>Ops! Something went wrong</h1>
 		   <b>${name}</b>:  ${message}
 		   <a href="${baseUrl}">Return to Home</a>
      </div>
     </div>
  </div>
<script src="${baseUrl}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${baseUrl}/assets/js/bootstrap.min.js"></script>
</body>
</html>
