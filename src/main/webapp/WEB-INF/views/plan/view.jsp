<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="bt" uri="http://www.mytest.it/bt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="baseUrl">${pageContext.request.contextPath}</c:set>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key="plan.title"/></title>
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
  		<li><a href="${baseUrl}/story/create.htm"><fmt:message key="story"/></a></li>
  		<li class="active"><a href="#"><fmt:message key="plan"/></a></li>
	</ul>
   	<h1>Project Plan</h1>
   	<div class="row-fluid">
		<div class="table-responsive">
			<table id="planTable" class="table table-bordered table-striped table-condensed">
				<thead>
					<tr>
						<th><fmt:message key="story.week"/></th>
						<th><fmt:message key="story.title"/></th>
						<th><fmt:message key="story.description"/></th>
						<th><fmt:message key="story.value"/></th>
						<th><fmt:message key="story.creationDate"/></th>
						<th><fmt:message key="story.status"/></th>
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
<script src="${baseUrl}/assets/js/jquery.dataTables.rowGrouping.js"></script>


	<script type="text/javascript">
	
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

	$('#planTable').dataTable({
		"sAjaxSource" : '${baseUrl}/rest/story',
		"sAjaxDataProp" : '_embedded.stories',
		"aoColumns" : [ {
			mDataProp : 'week',
			"mRender": function (data, type, full) {
          	  if (full!=null){
          	  	  console.log("week "+full.week);
          		  return "week "+full.week;
          	  }
          	}
		},{
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
		],
		"bServerSide" : true,
		"fnServerData" : datatable2Rest
	}).rowGrouping({ iGroupingColumnIndex: 0 ,sGroupLabelPrefix: "week "});
	</script>
</body>
</html>
