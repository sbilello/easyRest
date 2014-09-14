<%@tag description="Extended input tag for sophisticated errors" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@attribute name="springPath" required="true" type="java.lang.String"%>
<%@attribute name="label" required="true" type="java.lang.String"%>
<%@attribute name="property" required="true" type="java.lang.String"%>
<%@attribute name="required" required="false" type="java.lang.Boolean"%>


<div class="form-group">
	<label class="col-sm-4 control-label">
		<c:if test="${required}">
			<i class="glyphicon glyphicon-asterisk" style="color:red;"></i>
		</c:if>
		${label}
	</label>
	<div class="col-sm-4">
		<form:input path="${property}" cssClass="form-control" id="${property}" placeholder="${label}" />
		<spring:bind path="${springPath}">
     		<c:if test="${status.error}">
            	<p class="form-control-static"><i class="glyphicon glyphicon-warning-sign" style="color:red;"></i> ${status.errorMessage}</p>
        	</c:if>
       	</spring:bind>
    </div>
</div>
