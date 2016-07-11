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
	<link type="text/css" rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.css"/>

	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
$(function(){
	//加载列表grid
    $("#dataGrid").jqGrid({
        url: "system/role/page",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "角色管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
            {label:'角色', name:'ROLENAME',index:'ROLENAME', sortable:true, align:'center'},
            {label:'菜单权限', name:'MENUS',index:'MENUS', sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
        rowNum:10,
        rowList:[15,30,50],
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
         var a3 = "<a class='gridOper' href=\"javascript:setRoleMenu("+colValue.ID+")\"><img src=\"images/grid_set.png\">权限设置</a> ";
		return a1+a2+a3;
	}
    
    //新增
	$("#add_btn").click(function() {
		openDialog_S('system/role/edit', '新增角色')
	});
	//批量删除
	$("#del_btn").click(function() {
		    var ids = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
		    if(ids.length == 0){
		    	showSuccessMsg("请选择数据");
		     	return;
		    }
		    batchDelete(ids);
	});
	//查询
	$("#search_btn").click(function(){
			var param = {};
			var formArray = $("#queryForm").serializeArray();
			for(var i=0; i<formArray.length; i++ ){
				param[formArray[i].name] = formArray[i].value;
			}
			doSearch(param);
			
	});
	//查询条件重置
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
	function delItem(id){
		batchDelete([id]);
	}
	function batchDelete(ids){
		layer.confirm("确认删除？", function(index){
			myAjax({ url: "system/role/doDelete", 
				data: {ids: ids},
				success: function(result){
					showSuccessMsg("删除成功");
					reloadGrid();
				}
			});
		    layer.close(index);
		});
	}
	//修改
	function editItem(id){
		openDialog_S("system/role/edit?id="+id, '修改角色');
	}
	//修改
	function setRoleMenu(id){
		openDialog("system/role/roleMenu?id="+id, '权限设置', '600px', '400px');
	}
	//重载grid
	function reloadGrid(){
		$("#dataGrid").trigger("reloadGrid");
	}
</script>
</head>
<body>
       <div id="main" class="main">
       
	   <form id="queryForm">
	   <div class="whiteBox actionArea">
			<span>角色：</span>
			<span class="inputBox"><input name="roleName" type="text" class="inputText" size="35"></span>
		    <span>菜单：</span>
		    <span class="inputBox"><input name="menuName" type="text" class="inputText" size="35"></span>
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