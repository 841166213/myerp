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
        url: "gjj/zhbgPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "账户变更管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:'350'},
            {label:'申报单位名称', name:'DWMC',index:'DWMC', sortable:false, align:'center'},
            {label:'申报时间', name:'SBSJ',index:'SBSJ', sortable:true, align:'center'},
            {label:'组织机构代码', name:'ZZJGDM',index:'ZZJGDM', sortable:false, align:'center'},
            {label:'所属区县', name:'SSQX',index:'SSQX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.stqx}},
            {label:'单位地址', name:'DWSZDZ',index:'DWSZDZ', sortable:false, align:'center', width:'300px'},
            {label:'邮政编码', name:'YZBM',index:'YZBM', sortable:false, align:'center'},
            {label:'单位性质(变更后)', name:'DWXZ',index:'DWXZ', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.sb_dwxz}},
            {label:'经办人', name:'JBR',index:'JBR', sortable:false, align:'center'},
            {label:'变更原因', name:'BGYY',index:'BGYY', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.dw_zhbgyy}},
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
	    	var a1 = "<a class='gridOper' href=\"javascript:zhbgEdit("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">编辑明细</a> "; 
    		var a2 = "<a class='gridOper' href=\"javascript:zhbgConfirm("+colValue.ID+")\" ><img src=\"images/grid_right.png\">确认</a> "; 
    		var a3 = "<a class='gridOper' href=\"javascript:zhbgCancel("+colValue.ID+")\" ><img src=\"images/grid_del.png\">删除</a> "; 
    		return a1+a2+a3;
    	}else{
	    	var a1 = "<a class='gridOper' href=\"javascript:zhbgView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">明细查看</a> "; 
	    	var a2 = "<a class='gridOper' href=\"javascript:zhbgPrint("+colValue.ID+")\" ><img src=\"images/grid_print.png\">打印</a> "; 
			return a1+a2;
    	}
	}
    
	$("#add_btn").click(function() {
		openDialog_L('gjj/zhbgEdit', '账户变更登记')
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
	
	function zhbgEdit(id){
		openDialog_L("gjj/zhbgEdit?id="+id, '账户变更登记修改');
	}
	function zhbgView(id){
		openDialog_L("gjj/zhbgView?id="+id, '账户变更登记查看');
	}
	function zhbgCancel(id){
		layer.confirm("确认删除？",function(index){
			myAjax({
				url: "gjj/zhbgCancel",
				data: {id: id},
				success: function(r){
					showSuccessMsg("取消成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
	function zhbgConfirm(id){
		layer.confirm("确认后不能修改/删除？",function(index){
			myAjax({
				url: "gjj/zhbgConfirm",
				data: {ID: id},
				success: function(r){
					showSuccessMsg("确认成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
	function zhbgPrint(id){
		window.open("<%=basePath%>gjj/zhbgPrint?id="+id);
	}
</script>
</head>
<body>
      <div id="main" class="main">
      
   <form id="queryForm">
   <div class="whiteBox actionArea">
		<span>单位名称：</span>
		<span class="inputBox">
			<input name="dwmc" type="text" class="inputText">
		</span>
	    <span>组织机构代码：</span>
	    <span class="inputBox">
	    	<input name="zzjgdm" type="text" class="inputText">
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
			    <input type="button" id="add_btn" class="button" value="变更登记"/>
		    </div>
			<!-- jqGrid table dataGrid -->
			<table id="dataGrid"></table>
			<!-- jqGrid 分页 div gridPager -->
			<div id="gridPager"></div>
		</div>
	</div>
   </div> 
</body>