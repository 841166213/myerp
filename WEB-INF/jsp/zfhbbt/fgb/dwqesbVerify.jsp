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
	<script type="text/javascript" src="js/zfhbbt.js"></script>
<script>
var dwsbId = ${param.id};
var importList = [];
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "sb/dwqesbPage",
        datatype:"json",
        mtype:"POST",
        postData: {DWSBID: dwsbId},
        height:'auto',
        autowidth:true,
        shrinkToFit: false,
        caption: "全额申报",
        colModel:[
            {label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:'250px'},
            {label:'审核状态', name:'SHZT_SBXX',index:'SHZT_SBXX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.shzt}, width:'80px'},
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center', width:'100px', formatter:formatXM},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center', width:'150px'},
            {label:'职务', name:'ZW',index:'ZW', sortable:false, align:'center', width:'100px'},
            {label:'参加工作时间', name:'CJGZSJ',index:'CJGZSJ', sortable:false, align:'center', width:'100px'},
            {label:'进入机关事业单位时间', name:'JRJGSYDWGZSJ',index:'JRJGSYDWGZSJ', sortable:false, align:'center', width:'150px'},
            {label:'居住情况', name:'JZQK',index:'JZQK', sortable:false, align:'center', width:'100px', formatter:'select', formatoptions:{value:STD.sb_jzqk}},
            {label:'现居住房屋地址', name:'XJZFWDZ',index:'XJZFWDZ', sortable:false, align:'center', width:'250px'},
            {label:'开始领取时间', name:'KSLQSJ',index:'KSLQSJ', sortable:false, align:'center', width:'100px'},
            {label:'已领取年数', name:'YLQNS',index:'YLQNS', sortable:false, align:'center', width:'100px'},
            {label:'上年度月发放标准', name:'SNDYFFBZ',index:'SNDYFFBZ', sortable:false, align:'center', width:'130px'},
            {label:'本年度月发放标准', name:'BNDYFFBZ',index:'BNDYFFBZ', sortable:false, align:'center', width:'130px'},
            {label:'本年度领取方式', name:'LQFS',index:'LQFS', sortable:false, align:'center', width:'100px', formatter:'select', formatoptions:{value:STD.sb_lqfs}},
            {label:'本年度发放额合计', name:'FFEHJ',index:'FFEHJ', sortable:false, align:'center', width:'130px'},
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
    	var a1 = "<a class='gridOper' href=\"javascript:doVerify(["+colValue.ID+"])\" ><img src=\"images/grid_edit.png\">审核</a> "; 
    	var a2 = "<a class='gridOper' href=\"javascript:viewDetail("+colValue.ID+")\" ><img src=\"images/grid_view.png\">申报详情</a> "; 
    	var a3 = "<a class='gridOper' href=\"javascript:viewRysbHistory('"+colValue.XM+"','"+colValue.SFZHM+"')\" ><img src=\"images/grid_view.png\">申报历史</a> ";
    	var a4 = "<a class='gridOper' href=\"javascript:editItem("+colValue.ID+")\" ><img src=\"images/grid_edit.png\">修改</a> ";
		return a1+a2+a3+a4;
	}
    function formatXM(value, colObjet, colValue){
    	var a1 = "<span onclick='showTips($(this))'>"+colValue.XM+"</span> "; 
		return a1;
	}
    
	
	$("#batchVerify").click(function() {
		var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    doVerify(s);
	});
	$("#historyCheck").click(function() {
		var s = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(s.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    doHistoryCheck(s);
	});
	$("#fcxxQuery").click(function() {
		var ids = $("#dataGrid").jqGrid('getGridParam', 'selarrrow');
	    if(ids.length == 0){
	    	layer.msg('请选择数据');
	     	return;
	    }
	    
	    for(var i=0; i < ids.length; i++){
	    	var data = $("#dataGrid").jqGrid('getRowData', ids[i]);
	    	data.SFZ = data.SFZHM;
	    	data.POSFZ = data.POSFZHM;
	    	importList.push(data);
	    }
	    openDialog_F("fcxx/importQueryResult?id=0", '查询结果');
	    
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
	function doVerify(ids){
		layer.open({
			  type: 1,
			  title: '审核全额申报信息',
			  area: ['500px', '200px'],
			  content: $('#verifyDialog'),
			  success: function(layero, index){
				$("#closeDialog").unbind('click').click(function() {
					layer.close(index);
				});
				$("#passButton").unbind('click').click(function() {
					var shyj = $("#SHYJ").val();
					myAjax({ url: "fgb/verifySbxx", 
						data: {ids: ids, SHZT_SBXX: "1", SHYJ_SBXX: shyj},
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
					myAjax({ url: "fgb/verifySbxx", 
						data: {ids: ids, SHZT_SBXX: "2", SHYJ_SBXX: shyj},
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
	function doHistoryCheck(ids){
		var title = "申报信息校验";
		var url = "fgb/sbxxCheck?sblx=1&ids="+ids.join(",");
		var id = "fgb.sbxxCheck";
		window.top.addTabByTitleAndUrl(title, url, id, null, true);
	}
	function editItem(id){
		openDialog_L("sb/rysbxxEdit?id="+id, '修改申报信息');
	}
	function viewDetail(id){
		openDialog_L("sb/rysbxxDetail?id="+id+"&sblx=1", '全额申报详情');
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
			    <span class="inputBox"><select name="SBND">
			    	<option value=""></option>
		        	<c:forEach var="item" items="${STD_LIST.sb_jzqk}">
		        		<option value="${item.VALUE}">${item.TEXT}</option>
		        	</c:forEach>
		        	</select>
		        </span>
			    <span>审核状态：</span>
			    <span class="inputBox"><select name=SHZT_SBXX>
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
				    <input type="button" id="historyCheck" class="button" value="申报信息校验"/>
				    <input type="button" id="fcxxQuery" class="button" value="房产查询"/>
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