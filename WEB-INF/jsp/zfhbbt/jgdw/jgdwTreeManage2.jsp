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
<script>
$(function(){
	
    $("#dataGrid").jqGrid({
        url: "jgdw/page",
        datatype:"json",
        mtype:"POST",
        height:'auto',
        autowidth:true,
        caption: "机关单位管理",
        colModel:[
			{label:'操作', name:'opt',index:'opt', formatter:formatOpt, sortable:false, align:'center', width:'200px'},
            {label:'单位名称', name:'DWMC',index:'DWMC', sortable:false, align:'center'},
            {label:'组织机构代码', name:'ZZJGDM',index:'ZZJGDM', sortable:true, align:'center'},
            {label:'单位性质', name:'DWXZ',index:'DWXZ', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.sb_dwxz}},
            {label:'单位经费来源', name:'DWJFLY',index:'DWJFLY', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.dw_jfly}},
            {label:'单位法人代码', name:'DWFRDM',index:'DWFRDM', sortable:true, align:'center'},
            {label:'所属区县', name:'SSQX',index:'SSQX', sortable:false, align:'center', formatter:'select', formatoptions:{value:STD.stqx}},
            {label:'单位所在地址', name:'DWSZDZ',index:'DWSZDZ', sortable:false, align:'center', width:'300px'},
            {label:'主管部门', name:'ZGBM',index:'ZGBM', sortable:false, align:'center'},
            {label:'编制人数', name:'BZRS',index:'BZRS', sortable:true, align:'center'},
            {label:'联系人', name:'LXR',index:'LXR', sortable:false, align:'center'},
            {label:'联系电话', name:'LXDH',index:'LXDH', sortable:false, align:'center'}            
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
		openDialog_M('jgdw/edit', '新增机关单位')
	});
	$("#import_btn").click(function() {
		var index = layer.open({
			  type: 1,
			  title: '导入',
			  area: ['500px', '200px'],
			  content: $('#importForm')
		}); 
		$("#closeImp").click(function() {
			layer.close(index);
		});
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
	
	function editItem(id){
		openDialog_M("jgdw/edit?id="+id, '修改机关单位');
	}
	
	function delItem(id){
		batchDelete([id]);
	}
	
	function batchDelete(ids){
		layer.confirm("确认删除？",function(index){
			myAjax({ url: "jgdw/doDelete", 
				data: {ids: ids},
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
			<span>单位名称：</span>
			<span class="inputBox">
				<input name="dwmc" type="text" class="inputText">
			</span>
		    <span>组织机构代码：</span>
		    <span class="inputBox">
		    	<input name="zzjgdm" type="text" class="inputText">
	        </span>
		    <span class="rightButton">
		       <input type="button" id="search_btn" class="button" value="查 询" /> 
			   <input type="button" id="reset_btn" class="button" value="重置" />
			</span>
		</div>
        </form>
		<div class="whiteBox noPadding wf100">
			<table width="100%" border="0" cellspacing="0" cellpadding="8">
				<tr id="menu1">
					<td id="menu1td1" width="190" colspan="2" class="borderB borderR"><span
						class="font14">客户分类</span> <span class="classifyEdit fr"> </span>
					</td>
					<td id="menu1td2" style="display: none">
					</td>
					<td id="" class="borderB">所属分类:<a id="category"><span
							class=" fontOrange2">客户分类</span></a></td>
				</tr>
				<tr>
					<td id="menu2" class="" valign="top" width="201">
						<ul id="treeDemo" class="ztree"
							style="width: 190px; overflow-x: auto;"></ul>
					</td>
					<td id="menu3" class="borderR" width="11" valign="center"
						style="padding: 0px;"><a id="" href="javascript:;"
						onclick='showOrHideClass(this)'
						class="unfold"></a></td>
					<td valign="top">
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
					</td>
				</tr>
			</table>
		</div>
		<!-- whitebox -->
		
    </div> 
    
</body>