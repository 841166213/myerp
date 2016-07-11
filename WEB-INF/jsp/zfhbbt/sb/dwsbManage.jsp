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
	<script type="text/javascript" src="js/zfhbbt.js"></script>
<script>
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "sb/dwsbPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "单位申报管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:320},
            {label:'状态', name:'ZT',index:'ZT', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.sb_zt}},
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
    	if(colValue.ZT == "0"){
    		var a1 = "<a class='gridOper' href=\"javascript:dwqeSbManage("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">全额申报</a> "; 
            var a2 = "<a class='gridOper' href=\"javascript:dwceSbManage("+colValue.ID+")\"><img src=\"images/grid_edit.png\">差额申报</a> ";
            var a3 = "<a class='gridOper' href=\"javascript:dwsbqkbEdit("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">申报情况</a> "
            var a4 = "<a class='gridOper' href=\"javascript:submitSb("+colValue.ID+")\"><img src=\"images/grid_right.png\">提交</a> ";
            var a5 = "<a class='gridOper' href=\"javascript:deleteSb("+colValue.ID+")\"><img src=\"images/grid_del.png\">删除</a> ";
            return a1+a2+a3+a4+a5;
    	}else if(colValue.ZT == "1"){
    		var a1 = "<a class='gridOper' href=\"javascript:dwqeSbView("+colValue.ID+",1)\" ><img src=\"images/grid_view.png\">全额申报</a> "; 
            var a2 = "<a class='gridOper' href=\"javascript:dwceSbView("+colValue.ID+",1)\"><img src=\"images/grid_view.png\">差额申报</a> ";
            var a3 = "<a class='gridOper' href=\"javascript:dwsbqkbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">申报情况</a> "
            return a1+a2+a3;
    	}
	}
    
	
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
	
	$("#add_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '新增单位申报',
			  area: ['500px', '200px'],
			  content: $('#addDwsb')
		}); 
		$("#closeImp").unbind("click");
		$("#closeImp").click(function() {
			layer.close(index);
		});
		$("#submitImp").unbind("click");
		$("#submitImp").click(function() {
			validSubmit(function(rs){
				if(rs.status == 'success'){
					showSuccessMsg("新增成功");
					reloadGrid();
					layer.close(index);
				}
				if(rs.status == 'fail'){
					layer.msg('新增成功，'+rs.message);
				}
			})
		});
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
	
	function dwqeSbManage(id){
		//var rowData = $("#dataGrid").getRowData(id);
		openDialog_F("sb/dwqesbManage?id="+id, "单位全额申报");		
	}
	function dwceSbManage(id){
		//var rowData = $("#dataGrid").getRowData(id);
		openDialog_F("sb/dwcesbManage?id="+id, "单位差额申报");
	}
	function dwsbqkbEdit(id){
		openDialog_F("sb/dwsbqkbEdit?id="+id, '单位申报情况编辑');
	}
	
	function submitSb(id){
		layer.confirm("确认提交？",function(index){
			myAjax({ url: "sb/doSubmit", 
				data: {ID: id},
				success: function(result){
					showSuccessMsg("提交成功");
					reloadGrid();
				}
			});
			layer.close(index);
		});
	}
	
	function deleteSb(id){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "sb/deleteDwsb", 
				data: {id: id},
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
		        	<c:forEach var="item" items="${STD_LIST.year}">
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
				    <input type="button" id="add_btn" class="button" value="新增"/>
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