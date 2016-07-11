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
	<link type="text/css" rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
	<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "system/menu/page",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "菜单管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:300},
            {label:'菜单级别', name:'TYPE',index:'TYPE', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.menu_type}},
            {label:'菜单名称', name:'MENUNAME',index:'MENUNAME', sortable:false, align:'center'},
            {label:'排序', name:'SEQ', index:'SEQ', sortable:true, align:'center'},
            {label:'父级菜单', name:'PARENTNAME',index:'PARENTNAME', sortable:true, align:'center'},
            {label:'菜单ID', name:'MENUID',index:'MENUID', sortable:true, align:'center'},
            {label:'地址', name:'URL', index:'URL', sortable:false, align:'center'},
            {label:'样式', name:'CLASS', index:'CLASS', sortable:false, align:'center'}
            
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
    	var a1 = "<a class='gridOper' href=\"javascript:editItem("+colValue.ID+","+colValue.TYPE+")\" ><img src=\"images/grid_edit.png\">编辑</a> "; 
        var a2 = "<a class='gridOper' href=\"javascript:delItem("+colValue.ID+")\"><img src=\"images/grid_del.png\">删除</a> ";
		return a1+a2;
	}
    
	$("#add1_btn").click(function() {
		openDialog_M('system/menu/edit?level=1', '新增一级菜单')
	});
	$("#add2_btn").click(function() {
		openDialog_M('system/menu/edit?level=2', '新增二级菜单')
	});
	$("#add3_btn").click(function() {
		openDialog_M('system/menu/edit?level=3', '新增三级菜单')
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
	
	function editItem(id, level){
		openDialog_M("system/menu/edit?id="+id+"&level=" + level, '修改菜单');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function cancelMenu(id){
		layer.confirm("确认注销？",function(index){
			myAjax({ url: "system/menu/cancelMenu", 
				data: {id: id},
				success: function(result){
					showSuccessMsg("操作成功");
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	function useMenu(id){
		layer.confirm("确认启用？",function(index){
			myAjax({ url: "system/menu/useMenu", 
				data: {id: id},
				success: function(result){
					showSuccessMsg("操作成功");
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "system/menu/doDelete", 
				data: {ids: ids},
				success: function(result){
					showSuccessMsg("删除成功");
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	$(function(){
		var setting = {
			data: {
				key: {
					name: "MENUNAME"
				},
				simpleData: {
					enable: true,
					idKey: "ID",
					pIdKey: "PARENTID",
					rootPId: ""
				}
			},
			callback : {
				onClick : onTreeClick
			}
		};
		myAjax({url: "system/menu/getAllMenu", success: function(rs){
			$.fn.zTree.init($("#treeDemo"), setting, rs.data);
		}})
		function onTreeClick(event, treeId, treeNode) {
			$("#menuName").val(treeNode.MENUNAME);
			$(".treeSelect").attr("style","position: absolute; margin: 7px 0 0 -105px;display: none");
		}
		$(".treeInput").click(function(){
			$(".treeSelect").show();
		});
		$(".treeInput, .treeSelect").click(function(event) {
			event.stopPropagation();
		});
		$(document).click(function() {
			$(".treeSelect").attr("style","position: absolute; margin: 7px 0 0 -105px;display: none");
		});
		
	});
</script>
</head>
<body>
       <div id="main" class="main">
       
	   <form id="queryForm">
	   <div class="whiteBox actionArea">
			<span>菜单名称：</span>
			<span class="inputBox"><input id="menuName" name="menuName" type="text" readonly class="inputText treeInput" ></span>
			<div id="treeSelect" class="treeSelect" style="position: absolute; margin: 7px 0 0 -105px; display: none">
				<div class="tips" id="classDiv">
					<h1 style="width: 180px; height: 300px; overflow: auto">
						<div class="value">
							<ul id="treeDemo" class="ztree" style="width: 190px; overflow-x: auto;"></ul>
						</div>
					</h1>
				</div>
			</div>
			<span>菜单级别：</span>
			<span class="inputBox"><select name="menuType">
					<option value=""></option>
					<c:forEach var="item" items="${STD_LIST.menu_type}">
					<option value="${item.VALUE}">${item.TEXT}</option>
					</c:forEach>
				</select></span>
			<span>是否注销：</span>
			<span class="inputBox"><select name="is_default">
					<option value=""></option>
					<c:forEach var="item" items="${STD_LIST.yes_no}">
					<option value="${item.VALUE}">${item.TEXT}</option>
					</c:forEach>
				</select></span>
			<span class="rightButton">
		       <input type="button" id="search_btn" class="button" value="查 询" /> 
			   <input type="button" id="reset_btn" class="button" value="重置" />
			</span>
		</div>
        </form>
		
		<div class="whiteBox actionArea">
			<div class="flexigrid">
			    <div style="padding-bottom: 10px;">
				    <input type="button" id="add1_btn" class="button" value="新增一级菜单"/>
				    <input type="button" id="add2_btn" class="button" value="新增二级菜单"/>
				    <input type="button" id="add3_btn" class="button" value="新增三级菜单"/>
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