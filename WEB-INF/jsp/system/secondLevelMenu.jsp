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
	<script type="text/javascript" src="js/page.js"></script>
<script>
$(function(){
	
	var firstLevleMenu =  toSelectJson($.ajax({url:"system/menu/getFirstLevleMenu",dataType: 'json',async:false}).responseJSON, "id", "menuName");
	
    $("#dataGrid").jqGrid({
        url: "system/menu/secondLevel/page",
        editurl: "system/menu/save",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "二级菜单管理",
        colModel:[
			{label:'操作', name:'ID',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
            {label:'菜单id', name:'MENUID',index:'MENUID', editable: true, sortable:false, align:'center'},
            {label:'菜单名称', name:'MENUNAME',index:'MENUNAME', editable: true, sortable:false, align:'center'},
            {label:'菜单url', name:'URL',index:'URL', editable: true, sortable:false, align:'center'},
            {label:'排序', name:'SEQ',index:'SEQ', editable: true, sortable:false, align:'center'},
            {label:'一级菜单', name:'PARENTID',index:'PARENTID', editable: true, edittype : "select", editoptions : {value:firstLevleMenu}, formatter:'select', formatoptions:{value:firstLevleMenu}, sortable:false, align:'center'}
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
		 var a1 = "<a  href=\"javascript:$('#dataGrid').jqGrid('editGridRow','"+value+"',{checkOnSubmit:true,checkOnUpdate:true,closeAfterEdit:true,closeOnEscape:true});\" >编辑</a> "; 
        var a2 = "<a  href=\"javascript:delItem("+value+")\">删除</a> ";
        var a3 = "<a  href=\"javascript:viewMenu('"+colValue.URL+"', '"+colValue.MENUNAME+"','"+colValue.MENUID+"')\">预览</a> ";
		return a1+a2+a3;
	}
    
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
	    	layer.msg('请选择数据');
	    }
	});
	$("#add_btn").click(function() {
	    jQuery("#dataGrid").editGridRow("new", {
	    });
	});
	$("#add_btn2").click(function() {
		layer.open({
		      type: 2,
		      title: '新增二级菜单',
		      maxmin: true, //开启最大化最小化按钮
		      area: ['893px', '600px'],
		      content: 'system/menu/secondLevel/add'
		 });
	    //showDialog_S("system/menu/secondLevel/add", '新增二级菜单');
	});
	
	$("#del_btn").click(function() {
			//layer.alert("阿斯顿发辣豆腐00");
			showAlertMsg("hello","删除成功");
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
	function delItem(id){
		batchDelete([id]);
	}
	function batchDelete(ids){
		
		$.ajax({ url: "system/menu/doDelete", 
			type: "post", 
			dataType: "text", 
			data: {ids: ids},
			success: function(result){
				showSuccessMsg("删除成功");
				$("#dataGrid").trigger("reloadGrid");
			}
		});
	}
	function toSelectJson(list, valueName, textName){
		var json = {};
		for(var i=0; i<list.length; i++){
			json[list[i][valueName]] = list[i][textName];
		}
		return json;
	}
	
	function viewMenu(url, name, id){
		parent.window.openTab(name, url, id, true);
	}
	
</script>
</head>
<body>
       <div id="main" class="main">
       
	   <form id="queryForm">
	   <div class="whiteBox actionArea">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tbody><tr>
					<td>
						       <select name="parentId" id="parentId" style="display:; ">
						       	   <option value=""></option>
							       <c:forEach var="item" items="${list}">
							       		<option value="${item.id}">${item.menuName}</option>
							       </c:forEach>
						       </select> 

						<ul class="fl mr5" onclick="">
							<li class="abreast">一级菜单：</li>
							<li class="abreast">
						       <select name="parentId" id="parentId" style="display:; ">
						       	   <option value=""></option>
							       <c:forEach var="item" items="${list}">
							       		<option value="${item.id}">${item.menuName}</option>
							       </c:forEach>
						       </select> 
				            </li>
						</ul>
						
				       </td>
					<td align="right">
						<div id="searchDiv" class="search fr mr5" style="display: block;">
							<input id="keyword" name="menuName" type="text" class="inputText" size="35" placeholder="搜索名称" title="搜索名称" >
							<input type="button" id="search_btn" class="button" value="查 询" /> 
							<input type="button" id="reset_btn" class="button" value="重置" />
						</div></td>
				</tr>
				<tr>
				</tr>
			</tbody></table>
		</div>
        </form>
		
		<div class="whiteBox actionArea">
			<div class="flexigrid">
			    <div style="padding-bottom: 10px;">
				    <input type="button" id="add_btn" class="button redButton" value="新增"/> 
				    <input type="button" id="add_btn" class="button" value="新增"/> 
				    <input type="button" id="add_btn2" class="button" value="新增2"/> 
				    <input type="button" id="del_btn" class="button" value="删 除"/> 
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
</body>