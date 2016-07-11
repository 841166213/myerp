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
    <title></title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="js/zTree_v3/css/zTreeStyle/zTreeStyle.css">
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="js/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
</head>
<script language="javascript">
var roleId = "${role.ID}"
var setting = {
	check: {
		enable: true
	},
	data: {
		key: {
			checked: "CHECKED",
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
$(function(){
	myAjax({url: "system/role/getRoleMenuEditTree", data: {roleId: roleId}, success: function(rs){
		$.fn.zTree.init($("#menuTree"), setting, rs.data).expandAll(true);
	}})
	
});

function doSubmit(){
	var treeObj = $.fn.zTree.getZTreeObj("menuTree");
	var nodes = treeObj.getCheckedNodes(true);
	var menuIds = [];
	for(var i=0; i<nodes.length; i++){
		menuIds[i] = nodes[i].ID;
	}
	myAjax({url:"system/role/updateRoleMenu", data:{roleId: roleId, menuIds: menuIds}, success:function(result){
		showSuccessMsg("保存成功");
		parentCancelReload();
	}})
	
};
</script>  
<body style="background: none;">
<div style="margin-bottom: 60px;">
<form id="editForm" action="system/role/save" method="post">
<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="70" align="right" valign="top" class="font14">角色：</td>
			<td valign="top">${role.ROLENAME}</td>
		</tr>
	</table>
	<div>
		<ul id="menuTree" class="ztree"></ul>
	</div>
</form>
</div>
<!-- content -->
<div class="bottomButton moveArea">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
