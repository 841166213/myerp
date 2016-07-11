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
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "system/standardsType/page",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "数据标准管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
            {label:'标准类型', name:'TYPE',index:'TYPE', sortable:true, align:'center'},
            {label:'定义', name:'TYPENAME',index:'TYPENAME', sortable:false, align:'center'}
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
    	var a1 = "<a class='gridOper' href=\"javascript:editName("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">定义维护</a> "; 
        var a2 = "<a class='gridOper' href=\"javascript:editItems('"+colValue.TYPE+"','"+colValue.TYPENAME+"')\"><img src=\"images/grid_edit.png\">数据项维护</a> ";
        var a3 = "<a class='gridOper' href=\"javascript:delItem('"+colValue.ID+"','"+colValue.TYPE+"')\"><img src=\"images/grid_del.png\">删除</a> ";
		return a1+a2+a3;
	}
    
	$("#add_btn").click(function() {
		openDialog_S('system/standardsType/edit', '新增数据标准')
	});
	
	$("#del_btn").click(function() {
	    var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    var types=[];
	    for(var i=0;i<s.length;i++){
	    	types[i]=$("#dataGrid").getRowData(s[i])["TYPE"];
	    }
	    batchDelete(s, types);
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
	
	function editName(id){
		myAjax({
			url:"system/standardsType/getById",
			data:{id:id},
			success:function(result){
				layer.prompt({
					  formType: 0,
					  value: result.data.TYPENAME,
					  title: '请输入标准定义'
					}, function(value, index, elem){
					  myAjax({
						  url:"system/standardsType/save",
						  data:{
							  ID:id,
							  TYPENAME:value},
						  success:function(){
							  showSuccessMsg("操作成功");
							  reloadGrid();
						  }
					  });
					  layer.close(index);
					});
			}
		});		
	}
	
	function editItems(type, typename){
		openDialog_L("system/standards/manage?type="+type+"&typename="+typename, '数据项管理');
	}
	
	function delItem(id, type){
		batchDelete([id], [type]);
	}
	
	function batchDelete(ids, types){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "system/standardsType/doDelete", 
				data: {ids: ids, types: types},
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
			<span>标准类型：</span>
			<span class="inputBox"><input name="standardsType" type="text" class="inputText"></span>
			<span>定义：</span>
			<span class="inputBox"><input name="standardsName" type="text" class="inputText"></span>
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