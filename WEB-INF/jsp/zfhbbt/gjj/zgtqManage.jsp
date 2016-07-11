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
        url: "gjj/zgtqPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "职工提取（转移）申请管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
            {label:'单位名称', name:'DWID',index:'DWID', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},
            {label:'职工姓名', name:'XM',index:'XM', sortable:true, align:'center'},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center'},
            {label:'申请理由', name:'SQLY',index:'SQLY', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.zg_sqly}},
            {label:'状态', name:'ZT',index:'ZT', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.tjzt}}
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
    	if(colValue.ZT != '1'){
	    	var a1 = "<a class='gridOper' href=\"javascript:zgtqEdit("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">编辑明细</a> "; 
    		var a2 = "<a class='gridOper' href=\"javascript:zgtqConfirm("+colValue.ID+")\" ><img src=\"images/grid_right.png\">确认</a> "; 
    		var a3 = "<a class='gridOper' href=\"javascript:zgtqCancel("+colValue.ID+")\" ><img src=\"images/grid_del.png\">删除</a> "; 
    		return a1+a2+a3;
    	}else{
	    	var a1 = "<a class='gridOper' href=\"javascript:zgtqView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">明细查看</a> "; 
			return a1;
    	}
	}
    
	$("#add_btn").click(function() {
		openDialog_M('gjj/zgtqEdit', '职工提取（转移）申请')
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
	
	function zgtqEdit(id){
		openDialog_M("gjj/zgtqEdit?id="+id, '职工提取（转移）申请修改');
	}
	function zgtqView(id){
		openDialog_M("gjj/zgtqView?id="+id, '职工提取（转移）申请查看');
	}
	function zgtqCancel(id){
		layer.confirm("确认删除？",function(index){
			myAjax({
				url: "gjj/zgtqCancel",
				data: {id: id},
				success: function(r){
					showSuccessMsg("取消成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
	function zgtqConfirm(id){
		layer.confirm("确认后不能修改/删除？",function(index){
			myAjax({
				url: "gjj/zgtqConfirm",
				data: {ID: id},
				success: function(r){
					showSuccessMsg("确认成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
</script>
</head>
<body>
      <div id="main" class="main">
      
   <form id="queryForm">
   <div class="whiteBox actionArea">
		<span>职工姓名：</span>
		<span class="inputBox">
			<input name="xm" type="text" class="inputText">
		</span>
	    <span>身份证号码：</span>
	    <span class="inputBox">
	    	<input name="sfzhm" type="text" class="inputText">
        </span>
	    <span class="rightButton">
	       <input type="button" id="search_btn" class="button" value="查 询" /> 
		   <input type="button" id="reset_btn" class="button" value="重置" />
		</span>
	</div>
       </form>
	
	<div class="whiteBox actionArea">
		<div class="flexigrid">
		    <div style="padding-bottom: 10px;">
			    <input type="button" id="add_btn" class="button" value="提取（转移）申请"/>
		    </div>
			<!-- jqGrid table dataGrid -->
			<table id="dataGrid"></table>
			<!-- jqGrid 分页 div gridPager -->
			<div id="gridPager"></div>
		</div>
	</div>
   </div> 
</body>