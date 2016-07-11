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
<script>
var importList = [];
$(function(){
	
    $("#dataGrid").jqGrid({
        datatype:"local",
        height:'auto',
        caption: "单位申报管理",
        colModel:[
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证', name:'SFZ',index:'SFZ', sortable:false, align:'center'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center'},
            {label:'配偶身份证', name:'POSFZ',index:'POSFZ', sortable:false, align:'center'},
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
    });
    
    function formatOpt(value, colObjet, colValue){
    		var a1 = "<a class='gridOper' href=\"javascript:importQuery("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">查询</a> "; 
            return a1;
	}
    
	
	
    $("#import_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '导入',
			  area: ['500px', '200px'],
			  content: $('#importForm')
		}); 
		$("#closeImp").unbind("click").click(function() {
			layer.close(index);
		});
		$("#submitImp").unbind("click").click(function() {
			validSubmit(function(rs){
				$("#dataGrid").jqGrid('clearGridData');
				importList = rs.data;
				for ( var i = 0; i <= importList.length; i++){
				    $("#dataGrid").jqGrid('addRowData', i + 1, importList[i]);
				}
				layer.close(index);
			})
		});
	});
	
	
});

	function importQuery(id){
		openDialog_F("fcxx/importQueryResult?id="+id, '查询结果');
	}
	
</script>
</head>
<body>
	<div id="main" class="main">
		<div class="whiteBox actionArea">
			<div class="flexigrid">
			    <div style="padding-bottom: 10px;">
				    <input type="button" id="import_btn" class="button" value="导入查询Excel"/>
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
    
    <div id="importForm" style="display: none">
		<form id="validForm" action="fcxx/importQueryData" method="post">
			<input type="hidden" name='SBDWXX_ID' value="${param.id}"/>
			<table class="formTable">
				<tr>
					<td width="70" align="right" valign="top" class="font14">导入文件</td>
					<td valign="top"><input type="file" name='file' data-rule="required; excl" class="inputText" data-rule-excl="[/(.xls)$/, '请导入excel文件（.xls）']"/></td>
				</tr>
				<tr>
					<td width="70" align="right" valign="top" class="font14"></td>
					<td valign="top"><a href="javascript: downloadMode('房产信息导入查询模板.xls');">下载导入模板</a></td>
				</tr>
			</table>
		</form>
		<div class="bottomButton">
			<input type="button" id="submitImp" value="保存" class="button redButton"/>	
		    <input type="button" id="closeImp" value="关闭" class="button"/>
		</div>
		<!-- bottomButton -->
	</div>
</body>