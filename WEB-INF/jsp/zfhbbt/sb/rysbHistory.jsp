<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<title></title>
	<link href="./css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="js/jquery-ui-1.11.2.custom/jquery-ui.theme.min.css"/>
	<link type="text/css" rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.css"/>

	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
	<script type="text/javascript" src="js/zfhbbt.js"></script>
<script>
var sfzhm = "${param.sfzhm}";
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "sb/rysbHistoryPage",
        datatype:"json",
        mtype:"POST",
        postData: {SFZHM: sfzhm},
        height:'auto',
        autowidth:true,
        caption: "${param.xm} 申报历史",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
			{label:'申报年度', name:'SBND',index:'SBND', sortable:false, align:'center'},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},
            {label:'申报类型', name:'SBLX',index:'SBLX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.sb_sblx}},
            {label:'本年度发放额合计', name:'FFEHJ',index:'FFEHJ', sortable:false, align:'center'},
            {label:'申报信息审核状态', name:'SHZT_SBXX',index:'SHZT_SBXX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.shzt}}
        ],
        rownumbers:true,
        viewrecords: true,
        rowNum:10,
        rowList:[10,100,1000],
        jsonReader : {
        	id: "ID",  
			root: "list",
			repeatitems: false 
		},
		prmNames : {
			page:"page",
			rows:"rows" 
		},
        pager:$('#gridPager')
    });
    
    function formatOpt(value, colObjet, colValue){
    	var a1 = "<a class='gridOper' href=\"javascript:viewRySbDetail("+colValue.ID+","+colValue.SBLX+")\" ><img src=\"images/grid_view.png\">详情</a> "; 
		return a1;
	}
	
	$("#search_btn").click(function(){
			var param = {};
			var formArray = $("#queryForm").serializeArray();
			for(var i=0; i<formArray.length; i++ ){
				param[formArray[i].name] = formArray[i].value;
			}
			doSearch(param);
			
	});
	
	$("#reset_btn").click(function(){
		$("#queryForm").resetForm();
	});
});

function doSearch(param){
	var postData = $("#dataGrid").getGridParam("postData");
	$.extend(postData, param);
	$("#dataGrid").setGridParam({
		search: true,
		page: 1
	}).trigger("reloadGrid");
}
</script>
</head>
<body>
       <div id="main" class="main">
       <form id="queryForm">
	   <div class="whiteBox actionArea">
			    <span>申报类型：</span>
			    <span class="inputBox"><select name="SBLX">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.sb_sblx}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
		        <span>人员信息审核状态：</span>
			    <span class="inputBox"><select name="SHZT_RYXX">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.shzt}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
		        <span>申报信息审核状态：</span>
			    <span class="inputBox"><select name="SHZT_SBXX">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.shzt}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
			    <span class="rightButton">
			       <input type="button" id="search_btn" class="button" value="查 询" /> 
				   <input type="button" id="reset_btn" class="button" value="重置" />
				</span>
			</div>
        </form>
		
		<div class="whiteBox actionArea">
			<div class="flexigrid">
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div>
</body>