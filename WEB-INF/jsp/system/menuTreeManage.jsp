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
	<link type="text/css" rel="stylesheet" href="js/jqgrid/css/ui.jqgrid.css"/>

	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/jqgrid/js/i18n/grid.locale-cn.js"></script>
	<script type="text/javascript" src="js/jqgrid/src/jquery.jqGrid.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<link type="text/css" rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
	<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
<script>
	$(function(){
		var setting = {
			data: {
				key: {
					name: "MENUNAME"
				},
				simpleData: {
					enable: true,
					idKey: "ID",
					pIdKey: "PARENTID",
					rootPId: ""
				}
			}
		};
		myAjax({url: "system/menu/getAllMenu", success: function(rs){
			$.fn.zTree.init($("#treeDemo"), setting, rs.data).expandAll(true);
		}})
		
	});
</script>
</head>
<body>
       <div id="main" class="main">
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
    </div> 
</body>