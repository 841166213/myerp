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
        url: "zwzj/page",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "职务职级对应管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:'200px'},
            {label:'职务', name:'ZW',index:'ZW', sortable:false, align:'center'},
            {label:'分类', name:'ZWLB',index:'ZWLB', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.zwlb}},
            {label:'行政职级', name:'XZZJ',index:'XZZJ', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.xzzj}}
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
		openDialog_S('zwzj/edit', '新增职务职级对应')
	});
	
	$("#del_btn").click(function() {
		    var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
		    if(s.length == 0){
		    	layer.msg('请选择数据');
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
		openDialog_S("zwzj/edit?id="+id, '修改职务职级对应');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "zwzj/doDelete", 
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
			<span>职务：</span>
			<span class="inputBox">
				<input name="zw" type="text" class="inputText">
			</span>
		    <span>分类：</span>
		    <span class="inputBox">
		    	<input name="zwlb" type="text" class="inputText">
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
				    <input type="button" id="add_btn" class="button" value="新增"/>
				    <input type="button" id="del_btn" class="button" value="批量删除"/> 
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
</body>