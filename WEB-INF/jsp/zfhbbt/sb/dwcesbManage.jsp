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
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
var dwsbId = ${param.id};
var dwmc = "${data.DWMC}";
var sbnd = ${data.SBND};
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "sb/dwcesbPage",
        datatype:"json",
        mtype:"POST",
        postData: {DWSBID: dwsbId},
        height:'auto',
        autowidth:true,
        shrinkToFit: false,
        caption: "单位: "+dwmc+"， 年度: "+sbnd,
        colModel:[
            {label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:'150px'},
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center', width:'100px'},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center', width:'150px'},
            {label:'在职状态', name:'ZZZT',index:'ZZZT', sortable:false, align:'center', width:'100px', formatter:'select', formatoptions:{value:STD.sb_zzzt}},
            {label:'职务', name:'ZW',index:'ZW', sortable:false, align:'center', width:'100px'},
            {label:'居住情况', name:'JZQK',index:'JZQK', sortable:false, align:'center', width:'100px', formatter:'select', formatoptions:{value:STD.sb_jzqk}},
            {label:'房改面积', name:'FGMJ',index:'FGMJ', sortable:false, align:'center', width:'100px'},
            {label:'差额货币补贴总额', name:'CEHBBTZE',index:'CEHBBTZE', sortable:false, align:'center', width:'100px'},
            {label:'房屋所在地址', name:'FWSZDZ',index:'FWSZDZ', sortable:false, align:'center', width:'300px'},
            {label:'开始领取时间', name:'KSLQSJ',index:'KSLQSJ', sortable:false, align:'center', width:'100px'},
            {label:'已领取年数', name:'YLQNS',index:'YLQNS', sortable:false, align:'center', width:'100px'},
            {label:'上年度月发放标准', name:'SNDYFFBZ',index:'SNDYFFBZ', sortable:false, align:'center', width:'100px'},
            {label:'本年度月发放标准', name:'BNDYFFBZ',index:'BNDYFFBZ', sortable:false, align:'center', width:'100px'},
            {label:'本年度领取方式', name:'LQFS',index:'LQFS', sortable:false, align:'center', width:'100px', formatter:'select', formatoptions:{value:STD.sb_lqfs}},
            {label:'本年度发放额合计', name:'FFEHJ',index:'FFEHJ', sortable:false, align:'center', width:'100px'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center', width:'100px'},
            {label:'配偶身份证号码', name:'POSFZHM',index:'POSFZHM', sortable:false, align:'center', width:'150px'}
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
        var a2 = "<a class='gridOper' href=\"javascript:delItem("+colValue.ID+")\"><img src=\"images/grid_del.png\">删除</a> ";
		return a1+a2;
	}
    
	$("#add_btn").click(function() {
		openDialog_L('sb/rysbxxEdit?dwsbId='+dwsbId+"&sblx=2&sbnd="+sbnd, '新增差额申报')
	});
	
	$("#import_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '导入',
			  area: ['500px', '200px'],
			  content: $('#importForm')
		}); 
		$("#closeImp").unbind("click");
		$("#closeImp").click(function() {
			layer.close(index);
		});
		$("#submitImp").unbind("click");
		$("#submitImp").click(function() {
			validSubmit(function(rs){
				if(rs.status == 'success'){
					showSuccessMsg("导入成功");
					reloadGrid();
					layer.close(index);
				}
				if(rs.status == 'fail'){
					layer.msg('导入失败，'+rs.message);
				}
			})
		});
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
	
	$("#del_btn").click(function() {
	    var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    batchDelete(s);
	});
	
});

	function reloadGrid(){
		$("#dataGrid").trigger("reloadGrid");
		parent.reloadGrid();
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
		openDialog_L("sb/rysbxxEdit?id="+id+"&sblx=2&sbnd="+sbnd, '修改差额申报信息');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "sb/deleteRysbxx", 
				data: {ids: ids, DWSBID: ${param.id}},
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
				<span>姓名：</span>
				<span class="inputBox"><input name="XM" type="text" class="inputText"></span>
				<span>身份证：</span>
				<span class="inputBox"><input name="SFZHM" type="text" class="inputText"></span>
			    <span>居住情况：</span>
			    <span class="inputBox"><select name="JZQK">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.sb_jzqk}">
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
				    <input type="button" id="import_btn" class="button" value="导入"/>
				    <input type="button" id="del_btn" class="button" value="批量删除"/> 
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div>
    
    <div id="importForm" style="display: none">
		<form id="validForm" action="sb/importDwcesb" method="post">
			<input type="hidden" name='DWSBID' value="${param.id}"/>
			<table class="formTable">
				<tr>
					<td width="70" align="right" valign="top" class="font14">导入文件</td>
					<td valign="top"><input type="file" name='file' data-rule="required; excl" class="inputText" data-rule-excl="[/(.xls)$/, '请导入excel文件（.xls）']"/></td>
				</tr>
				<tr>
					<td width="70" align="right" valign="top" class="font14"></td>
					<td valign="top"><a href="sb/downloadDwcesbImportModel">下载导入模板</a></td>
				</tr>
			</table>
		</form>
		<div class="bottomButton">
			<input type="button" id="submitImp" value="保存" class="button redButton"/>	
		    <input type="button" id="closeImp" value="关闭" class="button"/>
		</div>
		<!-- bottomButton -->
	</div>
</body>