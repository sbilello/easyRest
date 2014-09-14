<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<html>
<head>
    <title><fmt:message key="story.edit"/></title>
	<link rel="stylesheet" href="${baseUrl}/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${baseUrl}/assets/css/datepicker.css">
	<link rel="stylesheet" href="${baseUrl}/assets/css/dataTables.bootstrap.css">
<!--[if lt IE 9]><link rel="stylesheet" href="${baseUrl}/assets/css/jquery.ui.1.10.3.ie.css"><![endif]-->
	<link rel="stylesheet" href="${baseUrl}/assets/css/custom-theme/jquery-ui-1.10.3.custom.css">
    <link rel="stylesheet" href="${baseUrl}/assets/css/custom-theme/jquery-ui-1.10.3.theme.css">
</head>
<body>
   <div class="container-fluid">
	<ul class="nav nav-pills">
  		<li><a href="${baseUrl}"><fmt:message key="return.home"/></a></li>
  		<li ><a href="${baseUrl}/developer/create.htm" ><fmt:message key="developer"/></a></li>
  		<li class="active"><a href="#"><fmt:message key="story"/></a></li>
  		<li><a href="${baseUrl}/story/plan.htm" ><fmt:message key="plan"/></a></li>
	</ul>
   	<h1>Story</h1>
   	<div class="row-fluid">
    <c:if test="${feedbackMessage != null}">
        <div class="alert alert-warning"><c:out value="${feedbackMessage}"/></div>
    </c:if>
    <c:if test="${errorMessage != null}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
    </c:if>
	</div>
	<div class="row-fluid">
 		<form:form class="form-horizontal" action="${baseUrl}/story/edit.htm" commandName="story" method="post">
           <form:hidden path="issueId"/>
           <bt:input springPath="story.title" label="Title" property="title" required="true"/>
           <bt:input springPath="story.description" label="Description" property="description" required="true"/>
           <bt:input springPath="story.value" label="Value" property="value" required="true"/>
           <div class="form-group">
	           	<label class="col-sm-4 control-label">
					<i class="glyphicon glyphicon-asterisk" style="color:red;"></i>
					<fmt:message key="story.creationDate"/>
				</label>
				<div class="col-sm-4">
					<form:input path="creationDate" cssClass="form-control" autocomplete="off"/>
					<spring:bind path="story.creationDate">
		     			<c:if test="${status.error}">
		            		<p class="form-control-static"><i class="glyphicon glyphicon-warning-sign" style="color:red;"></i> ${status.errorMessage}</p>
		        		</c:if>
			       	</spring:bind>
	    		</div>
    	   </div>
           <div class="form-group">
	           	<label class="col-sm-4 control-label">
					<i class="glyphicon glyphicon-asterisk" style="color:red;"></i>
					<fmt:message key="story.status"/>
				</label>
				<div class="col-sm-4">
					<form:select cssClass="form-control" path="status">
    					<form:options items="${status}" />
					</form:select>
					<spring:bind path="story.status">
		     			<c:if test="${status.error}">
		            		<p class="form-control-static"><i class="glyphicon glyphicon-warning-sign" style="color:red;"></i> ${status.errorMessage}</p>
		        		</c:if>
			       	</spring:bind>
	    		</div>
    	   </div>
    	   <div class="form-group">
	           	<label class="col-sm-4 control-label">
					<fmt:message key="story.developer"/>
				</label>
				<div class="col-sm-4">
					<form:hidden id="developerId" cssClass="form-control" path="developerId"/>
					<input type="text" class="form-control" id="developerString" autocomplete="off">
					<spring:bind path="story.developerId">
		     			<c:if test="${status.error}">
		            		<p class="form-control-static"><i class="glyphicon glyphicon-warning-sign" style="color:red;"></i> ${status.errorMessage}</p>
		        		</c:if>
			       	</spring:bind>
	    		</div>
    	   </div>
           <div class="text-center">
               <input type="submit" class="btn btn-default btn-md" value="<fmt:message key="story.edit.label"/>"/>
           </div>
        </form:form>
	</div>
	</div>
<script src="${baseUrl}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${baseUrl}/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="${baseUrl}/assets/js/jquery.dataTables.js"></script>
<script src="${baseUrl}/assets/js/bootstrap.min.js"></script>
<script src="${baseUrl}/assets/js/dataTables.bootstrap.js"></script>
<script src="${baseUrl}/assets/js/bootstrap-datepicker.js"></script>
<script src="${baseUrl}/assets/js/tmpl.min.js"></script>
<script type="text/javascript">
	$( "#creationDate" ).datepicker();
	var developerId = $("#developerId").val();
	if  (developerId!=null && developerId!=''){
		var url = '${baseUrl}/rest/developer/'+developerId;
		$.ajax({
			"dataType" : 'json',
			"type" : "GET",
			"url" : url,
			"success" : function(data) {
				if (data.name!=""){
					$('#developerString').val(data.name);
				}
			},
			"error": function(err){
				alert("OPS!"+err);
			}
		});
	}
	$('#developerString').tooltip({
		 trigger: 'onkeyup',    
		'placement': 'right',
		'title': '<fmt:message key="developer.autocomplete"/>'
	});
	$( "#developerString" ).autocomplete({
		 source: function( request, response ) {
			 	var name = escape($("#developerString").val());
				$.ajax({
					url: "${baseUrl}/rest/developer/search/findByNameContains",
					dataType: "json",		
					contentType: "application/json",													
					data:{ "sort":"name,asc",
						   "size":10,
					       "page":0,
					       "name":name},
					success: function(data) {
						if (data["_embedded"]!=null)
							response( $.map( data._embedded.developers, function( item ) {						
								var id = item._links.self.href.substr(item._links.self.href.lastIndexOf("/")+1,item._links.self.href.length);
								return {
									label: item.name,
									developerId: id
								};
							}));
					},
					error: function(err){
						alert("OPS!"+err);
					}
				});
		 },
		 minLength: 2,
		 select: function( event, ui ) {
		 	$("#developerId").val(ui.item.developerId);
		 }
	 });
	$("#developerString").keyup(function() {
	    if (!this.value) {
	        $("#developerId").val('');
	    }
	});
</script>
</body>
</html>