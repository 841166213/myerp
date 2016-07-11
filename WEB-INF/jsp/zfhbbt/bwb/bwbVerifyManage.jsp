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
	<script type="text/javascript" src="js/zfhbbt.js"></script>
<script>
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "bwb/bwbVerifyPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "编委办审核",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:100},
            {label:'审核状态', name:'SHZT_BWB',index:'SHZT_BWB', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.dwsb_shzt}},
			{label:'申报年度', name:'SBND',index:'SBND', sortable:true, align:'center'},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},
            {label:'全额申报人数', name:'BND_QE_RS',index:'BND_QE_RS', sortable:true, align:'center'},
            {label:'差额申报人数', name:'BND_CE_RS',index:'BND_CE_RS', sortable:true, align:'center'},
            {label:'申报总人数', name:'BND_HJ_RS',index:'BND_HJ_RS', sortable:true, align:'center'},
            {label:'申报总金额', name:'BND_HJ_JE',index:'BND_HJ_JE', sortable:true, align:'center'}           
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
    	if(colValue.SHZT_BWB == '1'){
    		var a1 = "<a class='gridOper' href=\"javascript:dwsbqkbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">查看</a> "; 
			return a1;
    	}else{
	    	var a1 = "<a class='gridOper' href=\"javascript:bwbVerify("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">审核</a> "; 
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
	
	function bwbVerify(id){
		openDialog_L("bwb/bwbVerify?id="+id, '编委办审核');
	}
	
	
</script>
</head>
<body>
	<div id="main" class="main">
	   <form id="queryForm">
	   <div class="whiteBox actionArea">
				<span>申报单位：</span>
				<span class="inputBox"><select name="SBDW">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.jgdw}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select></span>
			    <span>年度：</span>
			    <span class="inputBox"><select name="SBND">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.nd}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
			    <span>审核状态：</span>
			    <span class="inputBox"><select name="SHZT_BWB">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.dwsb_shzt}">
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
    
    <div id="addDwsb" style="display: none">
	<form id="validForm" action="sb/addDwsb" method="post">
		<input type="hidden" name='ID' value="${data.ID}"/>
		<table class="formTable">
			<tr>
				<td width="70" align="right" valign="top" class="font14">申报单位</td>
				<td valign="top"><select name="DWID" data-rule="required;">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.jgdw}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select></td>
			</tr>
			<tr>
				<td width="70" align="right" valign="top" class="font14">申报年度</td>
				<td valign="top"><select name="SBND">
		        	<c:forEach var="item" items="${STD_LIST.year}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select></td>
			</tr>
		</table>
	</form>
	<div class="bottomButton">
		<input type="button" id="submitImp" value="保存" class="button redButton"/>	
	    <input type="button" id="closeImp" value="关闭" class="button"/>
	</div>
	</div>
</body>