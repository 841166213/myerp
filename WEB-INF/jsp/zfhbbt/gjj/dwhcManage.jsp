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
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "gjj/dwhcPage",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        shrinkToFit: false,
        caption: "单位汇储登记管理",
        colModel:[
            {label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:200},
            {label:'登记状态', name:'DJZT_GJJ',index:'DJZT_GJJ', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.gjj_djzt}},
            {label:'申报年度', name:'SBND',index:'SBND', sortable:false, align:'center'},
            {label:'申报单位', name:'DWID',index:'DWID', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.jgdw}},  
            {label:'申报人数', name:'BND_HJ_RS',index:'BND_HJ_RS', sortable:false, align:'center'},
            {label:'拨款金额', name:'BKJE',index:'BKJE', sortable:false, align:'center'},
            {label:'登记日期', name:'DJRQ',index:'DJRQ', sortable:false, align:'center'}
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
    	if(colValue.DJZT_GJJ == '1'){
	    	var a1 = "<a class='gridOper' href=\"javascript:dwsbqkbView("+colValue.ID+")\" ><img src=\"images/grid_view.png\">登记详情</a> "; 
    		return a1;
    	}else{
	    	var a1 = "<a class='gridOper' href=\"javascript:dwdjEdit("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">单位登记</a> "; 
	    	var a2 = "<a class='gridOper' href=\"javascript:dwdjSubmit("+colValue.ID+")\" ><img src=\"images/grid_right.png\">提交登记</a> "; 
			return a1+a2;
    	}
	}
    
	$("#add_btn").click(function() {
		var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    myAjax({url: "czj/addZjhbpcmx", data:{ids: s, ZJHBPC_ID: id}, success: 
	    	function(r){
		    	showSuccessMsg("添加成功");
				parentCancelReload();
	    	}
	    })
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
	function dwdjEdit(id){
		openDialog_L("gjj/dwdjEdit?id="+id, "单位登记")
	}
	function dwdjSubmit(id){
		layer.confirm("确认提交？",function(index){
			myAjax({
				url: "gjj/dwdjSubmit",
				data: {id: id},
				success: function(r){
					showSuccessMsg("提交成功");
					reloadGrid();
				}
			})
			layer.close(index);
		});
	}
	
	function doSearch(param){
		var postData = $("#dataGrid").getGridParam("postData");
		$.extend(postData, param);
		$("#dataGrid").setGridParam({
			search: true,
			page: 1
		}).trigger("reloadGrid");
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
			    <span>登记状态：</span>
			    <span class="inputBox"><select name="DJZT">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.gjj_djzt}">
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