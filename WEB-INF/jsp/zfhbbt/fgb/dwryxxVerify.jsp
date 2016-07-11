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
var dwsbId = ${param.id};
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "fgb/dwryxxVerifyPage",
        datatype:"json",
        mtype:"POST",
        postData: {DWSBID: dwsbId},
        height:'auto',
        autowidth:true,
        caption: "编委办审核",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:100},
            {label:'审核状态', name:'SHZT_RYXX',index:'SHZT_RYXX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.shzt}},
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center'},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center'},
            {label:'职务', name:'ZW',index:'ZW', sortable:true, align:'center'},           
            {label:'参加工作时间', name:'CJGZSJ',index:'CJGZSJ', sortable:false, align:'center'},
            {label:'进入机关事业单位工作时间', name:'JRJGSYDWGZSJ',index:'JRJGSYDWGZSJ', sortable:false, align:'center'},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center'},
            {label:'配偶身份证号码', name:'POSFZHM',index:'SHZT_BWB', sortable:false, align:'center'},
            {label:'审核意见', name:'SHYJ_RYXX',index:'SHYJ_RYXX', sortable:false, align:'center'}
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
    	var a1 = "<a class='gridOper' href=\"javascript:doVerify(['"+colValue.ID+"'])\" ><img src=\"images/grid_edit.png\">审核</a> "; 
		return a1;
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
	
	$("#batchVerify").click(function() {
		var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    doVerify(s);
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
	function doVerify(ids){
		layer.open({
			  type: 1,
			  title: '审核人员信息',
			  area: ['500px', '200px'],
			  content: $('#verifyDialog'),
			  success: function(layero, index){
				$("#closeDialog").unbind('click').click(function() {
					layer.close(index);
				});
				$("#passButton").unbind('click').click(function() {
					var shyj = $("#SHYJ").val();
					myAjax({ url: "fgb/verifyRyxx", 
						data: {ids: ids, SHZT_RYXX: "1", SHYJ_RYXX: shyj},
						success: function(result){
							showSuccessMsg("审核成功");
							reloadGrid();
							parent.reloadGrid();
							layer.close(index);
						}
					});
				});
				$("#nopassButton").unbind('click').click(function() {
					var shyj = $("#SHYJ").val();
					myAjax({ url: "fgb/verifyRyxx", 
						data: {ids: ids, SHZT_RYXX: "2", SHYJ_RYXX: shyj},
						success: function(result){
							showSuccessMsg("审核成功");
							reloadGrid();
							parent.reloadGrid();
							layer.close(index);
						}
					});
				});
			}
				  
		}); 
	}
	function bwbVerify(id){
		openDialog_L("bwb/bwbVerify?id="+id, '编委办审核');
	}
	function dwryxxVerify(id){
		openDialog_L("fgb/dwryxxVerify?id="+id, '审核人员信息');
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
			    <span>审核状态：</span>
			    <span class="inputBox"><select name="SHZT_RYXX">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.shzt}">
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
				    <input type="button" id="batchVerify" class="button" value="批量审核"/>
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
				<!-- jqGrid 分页 div gridPager -->
				<div id="gridPager"></div>
			</div>
		</div>
    </div> 
    
    <div id="verifyDialog" style="display: none">
		<table class="formTable">
			<tr>
				<td width="70" class="textColumn">审核意见</td>
				<td><textarea id="SHYJ" cols="40" rows="4" name="SHYJ"></textarea></td>
			</tr>
		</table>
		<div class="bottomButton">
			<input type="button" id="passButton" value="通过" class="button redButton"/>	
			<input type="button" id="nopassButton" value="不通过" class="button redButton"/>	
		    <input type="button" id="closeDialog" value="关闭" class="button"/>
		</div>
	</div>
</body>