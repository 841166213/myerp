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
	<title>Parser Auto-Require Demonstration</title>
	<link href="./css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="js/jquery-ui-1.11.2.custom/jquery-ui.theme.min.css"/>
	<link type="text/css" rel="stylesheet" href="js/validator-0.7.3/jquery.validator.css"/>
	<link type="text/css" rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.css"/>

	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
	<style type="text/css">
	.ui-widget-header {font-weight:normal; color: rgb(51, 51, 51); background: rgb(255, 255, 255); }
	.ui-jqgrid .ui-jqgrid-titlebar { font-size: 14px;}
	</style>
<script>
var index = ${param.id};
var importList = parent.importList;
var allnum = "共" +　importList.length + "条";
$(function(){

    $("#dataGrid").jqGrid({
        datatype:"local",
        height:'auto',
        autowidth:true,
        colModel:[
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证', name:'SFZ',index:'SFZ', sortable:false, align:'center'},
            {label:'相识度', name:'XSD',index:'XSD', sortable:false, align:'center'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center'},
            {label:'配偶身份证', name:'POSFZ',index:'POSFZ', sortable:false, align:'center'},
            {label:'相识度', name:'POXSD',index:'POXSD', sortable:false, align:'center'},
            {label:'单位', name:'DW',index:'DW', sortable:false, align:'center'},
            {label:'面积', name:'MJ',index:'MJ', sortable:false, align:'center'},
            {label:'地址', name:'DZ',index:'DZ', sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
    });
    $("#dataGrid2").jqGrid({
        datatype:"local",
        height:'auto',
        autowidth:true,
        colModel:[
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证', name:'SFZ',index:'SFZ', sortable:false, align:'center'},
            {label:'相识度', name:'XSD',index:'XSD', sortable:false, align:'center'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center'},
            {label:'配偶身份证', name:'POSFZ',index:'POSFZ', sortable:false, align:'center'},
            {label:'相识度', name:'POXSD',index:'POXSD', sortable:false, align:'center'},
            {label:'单位', name:'DW',index:'DW', sortable:false, align:'center'},
            {label:'面积', name:'MJ',index:'MJ', sortable:false, align:'center'},
            {label:'地址', name:'DZ',index:'DZ', sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
    });
    
	function queryResult(){
		if(index > 0){
			$("#pre_btn").show();
		}else{
			$("#pre_btn").hide();
		}
		if(index < importList.length-1){
			$("#next_btn").show();
		}else{
			$("#next_btn").hide();
		}
		
		var data = importList[index];
		$("#spanId").html(" 第"+ (index + 1) + "条/" + allnum);
		$("#dataGrid").jqGrid('setCaption', "姓名："+ data.XM +"， 身份证：" + data.SFZ);
		$("#dataGrid2").jqGrid('setCaption', "配偶姓名："+ data.POXM +"，配偶 身份证：" + data.POSFZ);
		
	    myAjax({ url: "fcxx/importQueryResultData", 
			data: data,
			success: function(rs){
				var list1 = rs.data.list1;
				var list2 = rs.data.list2;
				$("#dataGrid").jqGrid('clearGridData');
				$("#dataGrid2").jqGrid('clearGridData');
				for ( var i = 0; i <= list1.length; i++){
				    $("#dataGrid").jqGrid('addRowData', i + 1, list1[i]);
				}
				for ( var i = 0; i <= list2.length; i++){
				    $("#dataGrid2").jqGrid('addRowData', i + 1, list2[i]);
				}
			}
		});
	}
    
    
    $("#pre_btn").click(function(){
    	index--;
    	queryResult()
	});
    $("#next_btn").click(function(){
    	index++;
    	queryResult()
	});
    
    queryResult();
});



</script>
</head>
<body>
	<div id="main" class="main">
		<div class="whiteBox actionArea">
			<div class="flexigrid">
				<div style="padding-bottom: 10px;">
				    <input type="button" id="pre_btn" class="button" value="上一条" />
				    <input type="button" id="next_btn" class="button" value="下一条"/>
				    <span id="spanId"></span>
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
			</div>
		</div>
		<div class="whiteBox actionArea">
			<div class="flexigrid">
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid2"></table>
			</div>
		</div>
    </div> 
    
</body>