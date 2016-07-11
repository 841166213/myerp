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
	<script type="text/javascript" src="js/laydate/laydate.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
var ids = "${param.ids}";
$(function(){

    $("#dataGrid").jqGrid({
    	caption: "生成批次明细详情",
        datatype:"local",
        height:'auto',
        autowidth:true,
        colModel:[
            {label:'申报年度', name:'SBND',index:'SBND', sortable:false, align:'center'},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},  
            {label:'申报人数', name:'BND_HJ_RS',index:'BND_HJ_RS', sortable:false, align:'center'},
            {label:'申报总金额', name:'BND_HJ_JE',index:'BND_HJ_JE', sortable:false, align:'center'},
            {label:'拨款比例', name:'BKBL',index:'BKBL', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.czj_bkbl}},
            {label:'拨款金额', name:'BKJE',index:'BKJE', sortable:false, align:'center'}
        ],
        rownumbers:true,
        viewrecords: true,
    });
    
    reloadGrid();
});

function reloadGrid(){
	myAjax({ url: "czj/getZjhbListByIds", 
		data: {ids: ids},
		success: function(rs){
			var list = rs.data;
			$("#dataGrid").jqGrid('clearGridData');
			var HBJE = 0;
			for ( var i = 0; i < list.length; i++){
			    HBJE += list[i].BKJE;
			    $("#dataGrid").jqGrid('addRowData', i + 1, list[i]);
			}
			$("#HBJE").val(HBJE);
			$("#HBMXS").val(list.length);
		}
	});
	
}
function doSubmit(){
	validSubmit(function(d){
		 showSuccessMsg("保存成功");
		 openTag("zfhbbt.czj.zjhbpcManage", "资金划拨批次管理", "czj/zjhbpcManage");
		 parentCancelReload();
	})
}
</script>
</head>
<body>
	<div id="main" class="main">
		<div class="whiteBox actionArea">
			<div class="flexigrid">
				<div style="padding-bottom: 10px;">
				<form id="validForm" action="czj/addZjbkpc" method="post">
				<input type="hidden" name="ids" value="${param.ids}">
					<span>批次：</span>
					<span class="inputBox"><input name="PC" type="text" class="inputText" data-rule="required" value="${data.PC}"></span>
					<span>划拨日期：</span>
					<span class="inputBox"><input name="HBRQ" type="text" class="inputText" value="${data.HBRQ}" onclick="laydate()"></span>
					<span>划拨金额：</span>
					<span class="inputBox"><input id="HBJE" name="HBJE" type="text" class="inputText" readonly></span>
					<span>明细数：</span>
					<span class="inputBox"><input id="HBMXS" name="HBMXS" type="text" class="inputText" readonly></span>
				    <input type="button" class="button redButton" value="保存" onclick="doSubmit()"/>
				</form>
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
			</div>
		</div>
    </div> 
    
</body>