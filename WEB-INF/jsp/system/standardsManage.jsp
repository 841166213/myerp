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
var type = "${param.type}";
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "system/standards/page",
        datatype:"json",
        mtype:"POST",
        postData: {type: type},
        height:'auto',
        autowidth:true,
        caption: "${param.typename} 数据项管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:300},
            {label:'数值', name:'VALUE',index:'VALUE', sortable:false, align:'center'},
            {label:'文本', name:'TEXT',index:'TEXT', sortable:false, align:'center'},
            {label:'是否注销', name:'IS_DELETE',index:'IS_DELETE', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.yes_no}},
            {label:'排序', name:'SEQ', index:'SEQ', sortable:true, align:'center'}
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
        var a2 = "<a class='gridOper' href=\"javascript:delItem("+colValue.ID+")\"><img src=\"images/grid_del2.png\">删除</a> ";
        var a3;
        if(colValue.IS_DELETE == '0'){
	        a3 = "<a class='gridOper' href=\"javascript:cancelStandard("+colValue.ID+")\"><img src=\"images/grid_del.png\">注销</a> ";
        }else{
	        a3 = "<a class='gridOper' href=\"javascript:useStandard("+colValue.ID+")\"><img src=\"images/grid_right.png\">启用</a> ";
        }
		return a1+a2+a3;
	}
    
	$("#add_btn").click(function() {
		openDialog_M('system/standards/edit?type=${param.type}', '新增数据标准')
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
		openDialog_M("system/standards/edit?id="+id, '修改数据标准');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function cancelStandard(id){
		layer.confirm("确认注销？",function(index){
			myAjax({ url: "system/standards/cancelStandard", 
				data: {id: id, type: type},
				success: function(result){
					showSuccessMsg("操作成功");
					getIndexWindow().initStd();
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	function useStandard(id){
		layer.confirm("确认启用？",function(index){
			myAjax({ url: "system/standards/useStandard", 
				data: {id: id, type: type},
				success: function(result){
					showSuccessMsg("操作成功");
					getIndexWindow().initStd();
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "system/standards/doDelete", 
				data: {ids: ids, type: type},
				success: function(result){
					showSuccessMsg("删除成功");
					getIndexWindow().initStd();
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
			<span>是否注销：</span>
			<span class="inputBox"><select name="is_delete">
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