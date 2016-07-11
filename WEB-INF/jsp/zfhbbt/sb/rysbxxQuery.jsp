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
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "sb/rysbxxPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "人员申报信息查询",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
			{label:'申报年度', name:'SBND',index:'SBND', sortable:true, align:'center'},
			{label:'申报单位', name:'DWID',index:'DWID', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},
			{label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center', width:200},
            {label:'申报类型', name:'SBLX',index:'SBLX', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.sb_sblx}},
            {label:'在职状态', name:'ZZZT',index:'ZZZT', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.sb_zzzt}},
            {label:'职务', name:'ZW',index:'ZW', sortable:false, align:'center'},
            {label:'本年度领取方式', name:'LQFS',index:'LQFS', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.sb_lqfs}},
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
	
	$("#qesbPrint").click(function(){
		window.open("<%=basePath%>sb/dwqesbPrint?id="+dwsbId);
	});
	$("#cesbPrint").click(function(){
		window.open("<%=basePath%>sb/dwcesbPrint?id="+dwsbId);
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
				<span>姓名：</span>
				<span class="inputBox"><input name="XM" type="text" class="inputText"></span>
				<span>身份证：</span>
				<span class="inputBox"><input name="SFZHM" type="text" class="inputText"></span>
				<span>申报单位：</span>
				<span class="inputBox"><select name="SBDW">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.jgdw}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select></span>
			    <span>年度：</span>
			    <span class="inputBox"><select name="SBND">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.year}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
		        <span>申报类型：</span>
			    <span class="inputBox"><select name="SBLX">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.sb_sblx}">
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