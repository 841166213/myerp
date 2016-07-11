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
        url: "czj/czjVerifyPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "财政局审核",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:200},
            {label:'审核状态', name:'SHZT_CZJ',index:'SHZT_CZJ', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.dwsb_shzt}},
            {label:'申报年度', name:'SBND',index:'SBND', sortable:false, align:'center'},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},  
            {label:'申报人数', name:'BND_HJ_RS',index:'BND_HJ_RS', sortable:false, align:'center'},
            {label:'申报总金额', name:'BND_HJ_JE',index:'BND_HJ_JE', sortable:false, align:'center'},
            {label:'拨款比例', name:'BKBL',index:'BKBL', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.czj_bkbl}},
            {label:'拨款金额', name:'BKJE',index:'BKJE', sortable:false, align:'center'}
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
    	var a1 = "<a class='gridOper' href=\"javascript:dwsbqkbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">申报情况查看</a> "; 
    	var a2 = "<a class='gridOper' href=\"javascript:czjVerify("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">审核</a> "; 
    	if(colValue.SHZT_CZJ == "1"){
    		return a1;
    	}
		return a1+a2;
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
	
	var gridData;
	function czjVerify(id){
		gridData = $("#dataGrid").getRowData(id);
		$("#validForm").resetForm();
		$("#ID").val(id);
		layer.open({
			  type: 1,
			  title: '财政局审核',
			  area: ['600px', '300px'],
			  content: $('#verifyDialog'),
			  success: function(layero, index){
				$("#closeDialog").unbind('click').click(function() {
					layer.close(index);
				});
				$("#passButton").unbind('click').click(function() {
					validSubmit(function(d){
						 showSuccessMsg("审核成功");
						 reloadGrid();
						layer.close(index);
					})
				});
			}
				  
		}); 
	}
	function changeBKBL(){
		var BKBL = $("#BKBL").val();
		if(BKBL == '1'){
			$("#BKJE").val(gridData.BND_HJ_JE).attr("readonly", true);
		}else{
			$("#BKJE").val("").removeAttr("readonly");
		}
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
			    <span class="inputBox"><select name="SHZT_CZJ">
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
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
    <div id="verifyDialog" style="display: none">
    	<form id="validForm" action="czj/czjPass" method="post">
    	<input type="hidden" id="ID" name='ID'/>
		<table class="formTable">
			<tr>
				<td width="20%" class="textColumn">划拨比例</td>
				<td><select id="BKBL" name="BKBL" data-rule="required" onchange="changeBKBL()">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.czj_bkbl}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select></td>
				<td width="20%" class="textColumn">划拨金额</td>
				<td><input type="text" id="BKJE" name='BKJE' data-rule="required;integer" class="inputText"/></td>
			</tr>
			<tr>
				<td width="70" class="textColumn">审核意见</td>
				<td colspan="3"><textarea id="SHYJ" cols="40" rows="4" name="SHYJ"></textarea></td>
			</tr>
		</table>
		</form>
		<div class="bottomButton">
			<input type="button" id="passButton" value="通过" class="button redButton"/>	
		    <input type="button" id="closeDialog" value="关闭" class="button"/>
		</div>
	</div>
</body>