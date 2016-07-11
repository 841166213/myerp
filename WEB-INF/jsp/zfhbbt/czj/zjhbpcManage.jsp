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
	<title></title>
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
        url: "czj/zjhbpcPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "资金划拨批次管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center'},
            {label:'批次', name:'PC',index:'PC', sortable:false, align:'center'},
            {label:'明细数', name:'HBMXS',index:'HBMXS', sortable:false, align:'center'},
            {label:'划拨金额', name:'HBJE',index:'HBJE', sortable:false, align:'center'},
            {label:'划拨日期', name:'HBRQ',index:'HBRQ', sortable:false, align:'center'},
            {label:'确认状态', name:'HBZT',index:'HBZT', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.czj_hbzt}}
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
    	if(colValue.HBZT != '1'){
	    	var a1 = "<a class='gridOper' href=\"javascript:zjhbpcEdit("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">编辑明细</a> "; 
    		var a2 = "<a class='gridOper' href=\"javascript:zjhbpcConfirm("+colValue.ID+")\" ><img src=\"images/grid_right.png\">确认</a> "; 
    		var a3 = "<a class='gridOper' href=\"javascript:zjhbpcCancel("+colValue.ID+")\" ><img src=\"images/grid_del.png\">删除</a> "; 
    		return a1+a2+a3;
    	}else{
	    	var a1 = "<a class='gridOper' href=\"javascript:zjhbpcView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">明细查看</a> "; 
			return a1;
    	}
	}
	
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
	
	function zjhbpcEdit(id){
		openDialog_F("czj/zjhbpcEdit?id="+id, '资金划拨明细编辑');
	}
	function zjhbpcView(id){
		openDialog_L("czj/zjhbpcView?id="+id, '资金划拨明细查看');
	}
	function zjhbpcCancel(id){
		layer.confirm("确认删除？",function(index){
			myAjax({
				url: "czj/zjhbpcCancel",
				data: {id: id},
				success: function(r){
					showSuccessMsg("取消成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
	function zjhbpcConfirm(id){
		layer.confirm("确认后不能修改/删除？",function(index){
			myAjax({
				url: "czj/zjhbpcConfirm",
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
				<span>批次：</span>
				<span class="inputBox"><input name="PC" type="text" class="inputText"></span>
			    <span>确认状态：</span>
			    <span class="inputBox"><select name="HBZT">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.czj_hbzt}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
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
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
</body>