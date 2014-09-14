<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<html>
<head>
    <title><fmt:message key="story.create"/></title>
    
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
	  		<li><a href="${baseUrl}/developer/create.htm" ><fmt:message key="developer"/></a></li>
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
	 		<form:form class="form-horizontal" action="${baseUrl}/story/create.htm" commandName="story" method="post">
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
	               <input type="submit" class="btn btn-default btn-md" value="<fmt:message key="story.submit.label"/>"/>
	           </div>
	        </form:form>
		</div>
		<div class="row-fluid">
			<div class="table-responsive">
				<table id="storyTable" class="table table-bordered table-striped table-condensed">
					<thead>
						<tr>
							<th><fmt:message key="story.title"/></th>
							<th><fmt:message key="story.description"/></th>
							<th><fmt:message key="story.value"/></th>
							<th><fmt:message key="story.creationDate"/></th>
							<th><fmt:message key="story.status"/></th>
							<th><fmt:message key="story.developer"/></th>
							<th><fmt:message key="story.actions"/></th>
						</tr>
					</thead>
					<tbody/>
				</table>	
			</div>
		</div>
		<div id="result"></div>
	</div>
<script type="text/x-tmpl" id="tmpl-demo">
<div class="modal fade" id="modalDeveloper">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><fmt:message key="developer.informations"/></h4>
      </div>
      <div class="modal-body">
		<div class="row">
       	 <div class="form-group">
	           	<label class="col-sm-4 control-label">
					<fmt:message key="story.developer"/>
				</label>
				<div class="col-sm-4">
					<p>{%=o.name%}</p>
	    		</div>
    	   </div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</script>	


<script src="${baseUrl}/assets/js/jquery-1.9.1.min.js"></script>
<script src="${baseUrl}/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="${baseUrl}/assets/js/jquery.dataTables.js"></script>
<script src="${baseUrl}/assets/js/bootstrap.min.js"></script>
<script src="${baseUrl}/assets/js/dataTables.bootstrap.js"></script>
<script src="${baseUrl}/assets/js/bootstrap-datepicker.js"></script>
<script src="${baseUrl}/assets/js/tmpl.min.js"></script>

	<script type="text/javascript">
	$( "#creationDate" ).datepicker();
	function showDeveloper(id){
		if (id!=null && id!=''){
			var url = '${baseUrl}/rest/developer/'+id;
			$.ajax({
				"dataType" : 'json',
				"type" : "GET",
				"contentType": "application/json",	
				"url" : url,
				"success" : function(data) {
					if (data.name!=""){
						document.getElementById("result").innerHTML=tmpl("tmpl-demo", data);
						$('#modalDeveloper').modal('show');
					}
				},
				"error": function(err){
					alert("OPS!"+err);
				}
			});
		}
	}
	showDeveloper($("#developerId").val());
	$("#developerString").keyup(function() {
	    if (!this.value) {
	        $("#developerId").val('');
	    }
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
					"error": function(err){
						alert("OPS!"+err);
					}
				});
		 },
		 minLength: 2,
		 select: function( event, ui ) {
		 	$("#developerId").val(ui.item.developerId);
		 }
	 }); 

	$('#developerString').tooltip({
		 trigger: 'onkeyup',    
		'placement': 'right',
		'title': '<fmt:message key="developer.autocomplete"/>'
	});

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
		restParams.push({"name" : "sort", "value" : sortName+","+sortDir });
	
		//if we are searching by name, override the url and add the name parameter
		var url = sSource;
		if (paramMap.sSearch != '') {
			url = "${baseUrl}/rest/story/search/findByTitle";
			restParams.push({ "name" : "title", "value" : paramMap.sSearch});
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
							data["_embedded"].stories=[];
					}
					data.iTotalRecords = data.page.totalElements;
					data.iTotalDisplayRecords = data.page.totalElements;
				}
				else {
					if (data["_embedded"]!=null){
						if (data["_embedded"].stories.length>0){
							data.iTotalRecords = data["_embedded"].stories.length;
							data.iTotalDisplayRecords = data["_embedded"].stories.length;
						}
					}
					else {
						data["_embedded"]={};
						data["_embedded"].stories=[];
						data.iTotalRecords = 0;
						data.iTotalDisplayRecords = 0;
					}
				}
				fnCallback(data);
			}
		});
	};

	$('#storyTable').dataTable({
		"sAjaxSource" : '${baseUrl}/rest/story',
		"sAjaxDataProp" : '_embedded.stories',
		"aoColumns" : [ {
			mDataProp : 'title'
		},
		{
			mDataProp : 'description'
		},
		{
			mDataProp : 'value'
		},
		{
			mDataProp : 'creationDate'
		},
		{
			mDataProp : 'status'
		},
		{
			mDataProp : 'developerId',
			mRender: function (data, type, full) {
           	  if (full.developerId!=null && full.developerId!=""){
           		  var id = full.developerId;
           	      var button = '<button class="btn btn-default" type="button" onclick="'
			 	  				+'showDeveloper('+id+');'+'">'
			 	 				+'<fmt:message key="show.developer"/>'
			 	                +'</button>';
           		  return button;
           	  }
           	  return "";
            }
		}],
		"bServerSide" : true,
		"fnServerData" : datatable2Rest,
		"aaSorting": [[3,'asc']],
		"aoColumnDefs": [
		                 {
		                      "aTargets": [6],
		                      "mData": null,
		                      "mRender": function (data, type, full) {
		                    	  if (full!=null){
		                    		  var id = full._links.self.href.substr(full._links.self.href.lastIndexOf("/")+1,full._links.self.href.length);
		                    	  	  var buttons =   '<a class="btn btn-primary"'+'href="'
		                    	  	  				 +'${baseUrl}/story/'+id+'/edit.htm"'+'>'
		                    	  	 				 +'<fmt:message key="story.edit"/>'
		                    	  	                 +'</a>';
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
