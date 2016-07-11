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
    <title>新增</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="js/validator-0.7.3/jquery.validator.css"/>
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
</head>
<script language="javascript">
function doSubmit(){
	validSubmit(function(d){
	     showSuccessMsg("保存成功");
	     parentCancelReload();
	});
};
</script>  
<body style="background: none;">
<form id="validForm" action="system/menu/save" method="post">
<div class="content" style="overflow: hidden; z-index: 999; opacity: 1; top: 13px; left: 475px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="8" class="formTable">
		<tbody><tr>
			<td width="70" align="right" valign="top" class="font14">菜单id</td>
			<td valign="top"><input type="text" name='MENUID' data-rule="required" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">菜单名称</td>
			<td valign="top"><input type="text" name='MENUNAME' data-rule="required" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">菜单url</td>
			<td valign="top"><input type="text" name='URL' data-rule="required" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">排序</td>
			<td valign="top"><input type="text" name='SEQ' data-rule="integer" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14" id="projectaccount_td">一级菜单</td>
			<td valign="top"><select name="PARENTID" data-rule="required">
						       <c:forEach var="item" items="${list}">
						       		<option value="${item.id}">${item.menuName}</option>
						       </c:forEach>
					        </select></td>
		</tr>
	</tbody></table>
</div>
</form>
<!-- content -->
<div class="bottomButton moveArea">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
