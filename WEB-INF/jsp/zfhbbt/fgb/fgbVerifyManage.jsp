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
        url: "fgb/fgbVerifyPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "房改办审核",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:430},
            {label:'审核状态', name:'SHZT_FGB',index:'SHZT_FGB', sortable:true, align:'center', formatter:'select', formatoptions:{value:STD.dwsb_shzt}, width:100},
            {label:'申报年度', name:'SBND',index:'SBND', sortable:true, align:'center', width:100},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},
            {label:'全额申报人数', name:'BND_QE_RS',index:'BND_QE_RS', sortable:true, align:'center'},
            {label:'差额申报人数', name:'BND_CE_RS',index:'BND_CE_RS', sortable:true, align:'center'},
            {label:'申报人数', name:'SBRS',index:'SBRS', sortable:false, align:'center', width:100},
            {label:'申报信息审核结果', name:'YSH_SBXX',index:'YSH_SBXX', sortable:false, align:'center', formatter:formatSbxxsh},
            {label:'申报情况审核结果', name:'SHZT_FGB_SBQK',index:'SHZT_FGB_SBQK', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.shzt}}
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
    	var a1 = "<a class='gridOper' href=\"javascript:dwqesbVerify("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">全额申报审核</a> "; 
    	var a2 = "<a class='gridOper' href=\"javascript:dwcesbVerify("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">差额申报审核</a> "; 
    	var a3 = "<a class='gridOper' href=\"javascript:dwsbqkVerify("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">申报情况审核</a> "; 
    	var a4 = "<a class='gridOper' href=\"javascript:submitVerify("+colValue.ID+","+colValue.SBRS+","+colValue.YSH_SBXX+","+colValue.BTG_SBXX+","+colValue.SHZT_FGB_SBQK+")\" ><img src=\"images/grid_right.png\">提交审核</a> "; 
    	var a5 = "<a class='gridOper' href=\"javascript:viewDwsbHistory("+colValue.DWID+")\" ><img src=\"images/grid_view.png\">申报历史</a> "; 
		if(colValue.SHZT_FGB==1){
			var a1 = "<a class='gridOper' href=\"javascript:dwqeSbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">全额申报</a> "; 
            var a2 = "<a class='gridOper' href=\"javascript:dwceSbView("+colValue.ID+")\"><img src=\"images/grid_view.png\">差额申报</a> ";
            var a3 = "<a class='gridOper' href=\"javascript:dwsbqkbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">申报情况</a> "
			return a1+a2+a3+a5;
		}else{
			return a1+a2+a3+a4+a5;
		}
	}
    function formatRyxxsh(value, colObjet, colValue){
		return "不通过"+colValue.BTG_RYXX+"/已审核"+colValue.YSH_RYXX;
	}
    function formatSbxxsh(value, colObjet, colValue){
		return "不通过"+colValue.BTG_SBXX+"/已审核"+colValue.YSH_SBXX;
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
	
	$("#add_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '新增单位申报',
			  area: ['500px', '200px'],
			  content: $('#addDwsb')
		}); 
		$("#closeImp").click(function() {
			layer.close(index);
		});
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
	
	function dwryxxVerify(id){
		openDialog_L("fgb/dwryxxVerify?id="+id, '单位人员信息审核');
	}
	function dwqesbVerify(id){
		openDialog_F("fgb/dwqesbVerify?id="+id, '单位全额申报审核');
	}
	function dwcesbVerify(id){
		openDialog_F("fgb/dwcesbVerify?id="+id, '单位差额申报审核');
	}
	function dwsbqkVerify(id){
		openDialog_L("fgb/fgbDwsbqkVerify?id="+id, '单位申报情况审核');
	}
	function submitVerify(id, sbrs, ysh_sbxx, btg_sbxx, shzt_fgb_sbqk){
		if(ysh_sbxx!=sbrs || btg_sbxx!=0 || shzt_fgb_sbqk!=1){
			layer.msg("未审核或审核不通过，不允许提交 ");
		}else{
			layer.confirm("确认提交？",function(index){
				myAjax({ url: "fgb/submitVerify", 
					data: {id: id},
					success: function(result){
						showSuccessMsg("提交成功");
						reloadGrid();
					}
				});
				layer.close(index);
			});
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
			    <span class="inputBox"><select name="SHZT_FGB">
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