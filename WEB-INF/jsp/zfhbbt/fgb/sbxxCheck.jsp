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
var ids = '${param.ids}';
var sblx = '${param.sblx}';
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "fgb/sbxxCheckList",
        datatype:"json",
        mtype:"POST",
        postData: {ids: ids},
        height:'auto',
        autowidth:true,
        shrinkToFit: false,
        caption: "申报信息校验",
        colModel:[
            {label:'比较', name:'SBND',index:'SBND', sortable:false, align:'center', width:'150px', formatter: formatBJ},
            {label:'身份证号码', name:'SFZHM',index:'SFZHM', sortable:false, align:'center', width:'200px'},
            {label:'姓名', name:'XM',index:'XM', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'职务', name:'ZW',index:'ZW', sortable:false, align:'center', width:'200px', formatter: formatCompare},
            {label:'居住情况', name:'JZQK',index:'JZQK', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            <c:if test="${param.sblx == '1'}">
            {label:'参加工作时间', name:'CJGZSJ',index:'CJGZSJ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'进入机关事业单位工作时间', name:'JRJGSYDWGZSJ',index:'JRJGSYDWGZSJ', sortable:false, align:'center', width:'200px', formatter: formatCompare},
            {label:'现居住房屋地址', name:'XJZFWDZ',index:'XJZFWDZ', sortable:false, align:'center', width:'300px', formatter: formatCompare},
            </c:if>
            <c:if test="${param.sblx == '2'}">
            {label:'房改面积', name:'FGMJ',index:'FGMJ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'差额货币补贴总额', name:'CEHBBTZE',index:'CEHBBTZE', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'房屋所在地址', name:'FWSZDZ',index:'FWSZDZ', sortable:false, align:'center', width:'300px', formatter: formatCompare},
            </c:if>
            {label:'开始领取时间', name:'KSLQSJ',index:'KSLQSJ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'已领取年数', name:'YLQNS',index:'YLQNS', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'上年度月发放标准', name:'SNDYFFBZ',index:'SNDYFFBZ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'本年度月发放标准', name:'BNDYFFBZ',index:'BNDYFFBZ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'本年度领取方式', name:'LQFS',index:'LQFS', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'本年度发放额合计', name:'FFEHJ',index:'FFEHJ', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'配偶姓名', name:'POXM',index:'POXM', sortable:false, align:'center', width:'100px', formatter: formatCompare},
            {label:'配偶身份证号码', name:'POSFZHM',index:'POSFZHM', sortable:false, align:'center', width:'150px', formatter: formatCompare}
        ],
        jsonReader : {
        	id: "ID",  
			root: "data",
			repeatitems: false 
		},
		treeGrid: true,
		treeGridModel: 'adjacency',
		ExpandColumn:"SBND",
		treeReader : {  
	      level_field: "level",  
	      parent_id_field: "parent",   
	      leaf_field: "isLeaf",  
	      expanded_field: "expanded"  
	    }
		
    });
    
    function formatBJ(value, colObjet, colValue){
    	if(colValue.level == 1){
    		return "比较"+value+"年度";
    	}else{
    		var indexes = ["XM", "ZW", "CJGZSJ", "JRJGSYDWGZSJ", "JZQK", "XJZFWDZ", "KSLQSJ", "YLQNS", "SNDYFFBZ", "BNDYFFBZ", "LQFS", "FFEHJ", "POXM", "POSFZHM"];
    		var n = 0;
    		for(var i=0; i<indexes.length; i++){
    			if(isWrongCheck(indexes[i], colValue)){
    	    		n++;
    	    	}
    		}
    		if(n > 0){
    			return "<span class='gridOper'><img src=\"images/grid_del.png\">"+n+"处</span>"; 
    		}
    		return "<span class='gridOper'><img src=\"images/grid_right.png\"></span>";
    	}
	}
    
    function formatCompare(value, colObjet, colValue){
    	var rs = value;
    	var index = colObjet.colModel.index;
    	//代码代码转换
    	if(index == 'JZQK'){
    		rs = STD.sb_jzqk[value]
    	}
    	if(index == 'LQFS'){
    		rs = STD.sb_lqfs[value]
    	}
    	//职务
    	if(index == 'ZW'){//职务
    		var xzzj = STD.zwzj[value];
    		if(xzzj == null){
    			rs = value + " [找不到对应职级]";
    		}else{
    			rs = value + " ["+ STD.xzzj[xzzj] +"]";
    		}
    	}
    	
    	if(isWrongCheck(index, colValue)){
    		rs = "<span class='gridOper'><img src=\"images/grid_del.png\">"+rs+"</span>";
    	}
    	return rs;
	}
    
    function isWrongCheck(index, colValue){
    	var value = colValue[index];
    	var flag = false;
    	if(index == 'YLQNS'){//已领年数
    		if(colValue[index+"_OLD"] != null && colValue[index] != colValue[index+"_OLD"] + 1){
	    		flag = true;
	    	}
    	}else if(index == 'ZW'){//职务
    		var xzzj = STD.zwzj[value];
    		if(xzzj == null){
    			flag = true;
    		}
    		if(colValue[index+"_OLD"] != null && colValue[index] != colValue[index+"_OLD"]){
	    		flag = true;
	    	}
    	}else if(index == 'SNDYFFBZ'){//上年度月发放标准
    		if(colValue[index+"_OLD"] != null && colValue[index] != colValue["BNDYFFBZ_OLD"]){
	    		flag = true;
	    	}
    	}else if(index == 'BNDYFFBZ'){//本年度月发放标准
    		var ZW = colValue["ZW"];
    		var YLQNS = colValue["YLQNS"];
    		var dyxzzj = STD.zwzj[ZW];
			var bndyffbz = getBNDYFFBZ(dyxzzj, YLQNS)
			if(bndyffbz != value){
				flag = true;
			}
    	}else if(index == 'FFEHJ'){//本年度月发放标准
    		var ZW = colValue["ZW"];
    		var YLQNS = colValue["YLQNS"];
    		var LQFS = colValue["LQFS"];
    		var FGMJ = colValue["FGMJ"];
    		var dyxzzj = STD.zwzj[ZW];
    		var sblx = colValue["SBLX"];
			var ze = getFFEHJ(sblx, dyxzzj, YLQNS, LQFS, FGMJ)	
			if(ze != value){
				flag = true;
			}
    	}else{
	    	if(colValue[index+"_OLD"] != null && colValue[index] != colValue[index+"_OLD"]){
	    		flag = true;
	    	}
    	}
    	return flag;
    }
	
});

	function reloadGrid(){
		$("#dataGrid").trigger("reloadGrid");
	}
	
</script>
</head>
<body>
       <div id="main" class="main">
		<div class="whiteBox actionArea">
			<div class="flexigrid">
			    <div style="padding-bottom: 10px;">
			    <input type="button" onclick="reloadGrid()" class="button" value="重新校验"/>
			    </div>
				<!-- jqGrid table dataGrid -->
				<table id="dataGrid"></table>
			</div>
		</div>
    </div>
    
</body>