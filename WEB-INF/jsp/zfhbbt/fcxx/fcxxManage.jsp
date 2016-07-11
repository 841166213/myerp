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
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "fcxx/fcxxQueryPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "房产信息管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
			{label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证', name:'SFZ',index:'SFZ', sortable:false, align:'center'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center'},
            {label:'配偶身份证', name:'POSFZ',index:'POSFZ', sortable:false, align:'center'},
            {label:'单位', name:'DW',index:'DW', sortable:false, align:'center'},
            {label:'面积', name:'MJ',index:'MJ', sortable:false, align:'center'},
            {label:'地址', name:'DZ',index:'DZ', sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
        rowNum:10,
        rowList:[10,100,1000],
        multiselect : true,
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
    	var a1 = "<a class='gridOper' href=\"javascript:editItem("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">编辑</a> "; 
        var a2 = "<a class='gridOper' href=\"javascript:delItem("+colValue.ID+")\"><img src=\"images/grid_del.png\">删除</a> ";
		return a1+a2;
	}
    
    $("#add_btn").click(function() {
		openDialog_M('fcxx/edit', '新增房产信息')
	});
    
    $("#import_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '导入',
			  area: ['500px', '200px'],
			  content: $('#importForm')
		}); 
		$("#closeImp").unbind("click");
		$("#closeImp").click(function() {
			layer.close(index);
		});
		$("#submitImp").unbind("click");
		$("#submitImp").click(function() {
			validSubmit(function(rs){
				if(rs.status == 'success'){
					showSuccessMsg("导入成功");
					reloadGrid();
					layer.close(index);
				}
				if(rs.status == 'fail'){
					layer.msg('导入失败，'+rs.message);
				}
			})
		});
	});
	
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

	function reloadGrid(){
		$("#dataGrid").trigger("reloadGrid");
	}
	
	function doSearch(param){
		var postData = $("#dataGrid").getGridParam("postData");
		$.extend(postData, param);
		$("#dataGrid").setGridParam({
			search: true,
			page: 1
		}).trigger("reloadGrid");
	}
	
	function editItem(id){
		openDialog_M("fcxx/edit?id="+id, '修改房产信息');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "fcxx/doDelete", 
				data: {ids: ids},
				success: function(result){
					showSuccessMsg("删除成功");
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
</script>
</head>
<body>
	<div id="main" class="main">
	   <form id="queryForm">
	   <div class="whiteBox actionArea">
				<span>姓名（配偶）：</span>
				<span class="inputBox"><input name="XM" type="text" class="inputText"></span>
			    <span>身份证（配偶）：</span>
			    <span class="inputBox"><input name="SFZ" type="text" class="inputText"></span>
			    <span>单位：</span>
			    <span class="inputBox"><input name="DW" type="text" class="inputText"></span>
			    <span>地址：</span>
			    <span class="inputBox"><input name="DZ" type="text" class="inputText"></span>
			    <span class="rightButton">
			       <input type="button" id="search_btn" class="button" value="查 询" /> 
				   <input type="button" id="reset_btn" class="button" value="重置" />
				</span>
			</div>
        </form>
		
		<div class="whiteBox actionArea">
			<div class="flexigrid">
			    <div style="padding-bottom: 10px;">
			    	<input type="button" id="add_btn" class="button" value="新增"/>
				    <input type="button" id="import_btn" class="button" value="导入"/>
				    <input type="button" id="del_btn" class="button" value="批量删除"/> 
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
    
    <div id="importForm" style="display: none">
		<form id="validForm" action="fcxx/importFcxx" method="post">
			<input type="hidden" name='ID' value="${data.ID}"/>
			<table class="formTable">
				<tr>
					<td width="70" align="right" valign="top" class="font14">导入文件</td>
					<td valign="top"><input type="file" name='file' data-rule="required; excl" class="inputText" data-rule-excl="[/(.xls)$/, '请导入excel文件（.xls）']"/></td>
				</tr>
				<tr>
					<td width="70" align="right" valign="top" class="font14"></td>
					<td valign="top"><a href="fcxx/downloadFcxxImportModel">下载导入模板</a></td>
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