<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<html>
<head>
    <title><fmt:message key="developer.title"/></title>
	<link rel="stylesheet" href="${baseUrl}/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${baseUrl}/assets/css/dataTables.bootstrap.css">		
<!--[if lt IE 9]><link rel="stylesheet" href="${baseUrl}/assets/css/jquery.ui.1.10.3.ie.css"><![endif]-->
	<link rel="stylesheet" href="${baseUrl}/assets/css/custom-theme/jquery-ui-1.10.3.custom.css">
	<link rel="stylesheet" href="${baseUrl}/assets/css/custom-theme/jquery-ui-1.10.3.theme.css">		
</head>
<body>
   <div class="container-fluid">
	   	<ul class="nav nav-pills">
	  		<li><a href="${baseUrl}"><fmt:message key="return.home"/></a></li>
	  		<li class="active"><a href="#" ><fmt:message key="developer"/></a></li>
	  		<li><a href="${baseUrl}/story/create.htm"><fmt:message key="story"/></a></li>
	  		<li><a href="${baseUrl}/story/plan.htm" ><fmt:message key="plan"/></a></li>
		</ul>
	   	<h1><fmt:message key="developer.title"/></h1>
	   	<div class="row-fluid">
	    <c:if test="${feedbackMessage != null}">
	        <div class="alert alert-warning"><c:out value="${feedbackMessage}"/></div>
	    </c:if>
	    <c:if test="${errorMessage != null}">
	        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
	    </c:if>
		</div>
		<div class="row-fluid">
	 		<form:form class="form-horizontal" action="${baseUrl}/developer/create.htm" commandName="developer" method="post">
	           <bt:input springPath="developer.name" label="Name" property="name" required="true"/>
	           <div class="text-center">
	               <input type="submit" class="btn btn-default btn-md" value="<fmt:message key="developer.create.page.submit.label"/>"/>
	           </div>
	        </form:form>
		</div>
		<div class="row-fluid">
			<div class="table-responsive">
				<table id="developerTable" class="table table-bordered table-striped table-condensed">
					<thead>
						<tr>
							<th><fmt:message key="developer.name"/></th>
							<th><fmt:message key="developer.actions"/></th>
						</tr>
					</thead>
					<tbody/>
				</table>	
			</div>
		</div>
	</div>
<script src="${baseUrl}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${baseUrl}/assets/js/jquery.dataTables.js"></script>
<script src="${baseUrl}/assets/js/dataTables.bootstrap.js"></script>
<script src="${baseUrl}/assets/js/bootstrap.min.js"></script>

	<script type="text/javascript">

	function deleteDeveloper(id){
		$.ajax({
			"dataType" : 'json',
			"type" : "DELETE",
			"url" : "${baseUrl}/rest/developer/"+id,
			"success" : function(data) {
				developerTable.fnDraw();
			},
			"error": function(err){
				// I should use a bootstrap modal
				alert("it's not possible delete "+id+" err "+err);
			}
		});
	}

	var datatable2Rest = function(sSource, aoData, fnCallback) {
		
		//extract name/value pairs into a simpler map for use later
		var paramMap = {};
		for ( var i = 0; i < aoData.length; i++) {
			paramMap[aoData[i].name] = aoData[i].value;
		}
	
		//page calculations
		var pageSize = paramMap.iDisplayLength;
		var start = paramMap.iDisplayStart;
		var pageNum = (start == 0) ? 0 : (start / pageSize) ;
		
		// extract sort information
		var sortCol = paramMap.iSortCol_0;
		var sortDir = paramMap.sSortDir_0;
		var sortName = paramMap['mDataProp_' + sortCol];
	
		//create new json structure for parameters for REST request
		var restParams = [];
		restParams.push({"name" : "size", "value" : pageSize});
		restParams.push({"name" : "page", "value" : pageNum });
		restParams.push({ "name" : "sort", "value" : sortName+","+sortDir });
	
		//if we are searching by name, override the url and add the name parameter
		var url = sSource;
		if (paramMap.sSearch != '') {
			url = "${baseUrl}/rest/developer/search/findByNameContains";
			restParams.push({ "name" : "name", "value" : paramMap.sSearch});
		}
		
		//finally, make the request
		$.ajax({
			"dataType" : 'json',
			"type" : "GET",
			"url" : url,
			"data" : restParams,
			"success" : function(data) {
				if (data.page!=null){
					if (data["_embedded"]==null){
							data["_embedded"]={};
							data["_embedded"].developers=[];
					}
					data.iTotalRecords = data.page.totalElements;
					data.iTotalDisplayRecords = data.page.totalElements;
				}
				else {
					if (data["_embedded"]!=null){
						if (data["_embedded"].developers.length>0){
							data.iTotalRecords = data["_embedded"].developers.length;
							data.iTotalDisplayRecords = data["_embedded"].developers.length;
						}
					}
					else {
						data["_embedded"]={};
						data["_embedded"].developers=[];
						data.iTotalRecords = 0;
						data.iTotalDisplayRecords = 0;
					}
				}
				fnCallback(data);
			}
		});
	};

	var developerTable = $('#developerTable').dataTable({
						"sAjaxSource" : '${baseUrl}/rest/developer',
						"sAjaxDataProp" : '_embedded.developers',
						"aoColumns" : [ {
							mDataProp : 'name'
						} ],
						"bServerSide" : true,
						"fnServerData" : datatable2Rest,
						"aoColumnDefs": [
						                 {
						                      "aTargets": [1],
						                      "mData": null,
						                      "mRender": function (data, type, full) {
						                    	  if (full!=null){
						                    		  var id = full._links.self.href.substr(full._links.self.href.lastIndexOf("/")+1,full._links.self.href.length);
						                    	  	  var buttons =   '<button class="btn btn-danger" type="button" onclick="'
						                    	  	  				 +'deleteDeveloper('+id+');'+'">'
						                    	  	 				 +'<fmt:message key="developer.delete"/>'
						                    	  	                 +'</button>';
						                    		  return buttons;
						                    	  }
						                    	  return "";
						                      }
						                 }
						]
					});
	</script>
</body>
</html>
