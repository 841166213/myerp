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
	<link type="text/css" rel="stylesheet" href="js/jquery-ui-1.11.2.custom/jquery-ui.theme.min.css"/>
	<link type="text/css" rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.css"/>

	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/jquery-ui-1.11.2.custom/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
<script>
$(document).ready(function(){
    $("#dataGrid").jqGrid({
        url: "system/menu/firstLevel/page",
        editurl: "system/menu/save",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "一级菜单管理",
        colModel:[
			{label:'操作', name:'ID',index:'opt', sortable:false, formatter:formatOpt, align:'center'},
            {label:'菜单id', name:'MENUID',index:'MENUID', editable: true, align:'center', sortable:false},
            {label:'菜单名称', name:'MENUNAME',index:'MENUNAME', editable: true, align:'center', sortable:false},
            {label:'排序', name:'SEQ',index:'SEQ', editable: true, align:'center', sortable:false}
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
        pager:$('#gridPager')
    });
    
    
    $("#adddata").click(function() {
	    jQuery("#dataGrid").jqGrid('editGridRow', "new", {
	      height : 300,
	      reloadAfterSubmit : false
	    });
	});
	
	$("#editdata").click(function() {
	    var row = jQuery("#dataGrid").jqGrid('getGridParam', 'selrow');
	    if (row != null){
	      jQuery("#dataGrid").editGridRow(row, {
	      });
	    }else{
	      $().message("请选择数据");
	    }
	});
	$("#add_btn").click(function() {
	    jQuery("#dataGrid").editGridRow("new", {
	    });
	});
	
	$("#del_btn").click(function() {
		    var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
		    if(s.length == 0){
		    	$().message("请选择数据");
		     	return;
		    }
		    batchDelete(s);
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
	
	load();
	
});

	function doSearch(param){
		var postData = $("#dataGrid").getGridParam("postData");
		$.extend(postData, param);
		$("#dataGrid").setGridParam({
			search: true,
			page: 1
		}).trigger("reloadGrid");
	}
	function delItem(id){
		batchDelete([id]);
	}
	function batchDelete(ids){
		$.ajax({ url: "system/menu/doDelete", 
			type: "post", 
			dataType: "text", 
			data: {ids: ids},
			success: function(result){
				$().message("删除成功");
				$("#dataGrid").trigger("reloadGrid");
			}
		});
	}
	function formatOpt(value, colObjet, colValue){
		 var a1 = "<a  href=\"javascript:$('#dataGrid').jqGrid('editGridRow','"+value+"',{checkOnSubmit:true,checkOnUpdate:true,closeAfterEdit:true,closeOnEscape:true});\" >编辑</a> "; 
         var a2 = "<a  href=\"javascript:delItem("+value+")\">删除</a> ";
		return a1+a2;
	}

</script>
</head>
<body>
<div id="opt"> 
	<form id="queryForm">
    <div id="query"> 
       <label>名称：</label><input type="text" class="input" name="menuName" /> 
       <input type="button" id="search_btn" value="查 询" /> 
       <input type="button" id="reset_btn" value="重置" /> 
    </div> 
    </form>
    <input type="button" id="add_btn" value="新增"/> 
    <input type="button" id="del_btn" value="删 除"/> 
</div>
<!-- jqGrid table dataGrid -->
<table id="dataGrid"></table>
<!-- jqGrid 分页 div gridPager -->
<div id="gridPager"></div>
</body>