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
    <link href="css/style.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="js/validator-0.7.3/jquery.validator.css"/>
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
</head>
<body style="background: none;">
<form id="validForm" action="system/menu/save" method="post">
	<input type="hidden" name='ID' id='ID' value="${data.ID}"/>
	<table class="formTable">
	<c:if test="${param.level == '3' }">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">菜单名称</td>
			<td width="20%" ><input type="text" name='MENUNAME' data-rule="required" class="inputText" value="${data.MENUNAME}"/><input type="hidden" name='TYPE' value="3"/></td>
			<td width="10%" align="right" valign="top" class="font14">菜单ID</td>
			<td width="20%" ><input type="text" name='MENUID' data-rule="required" class="inputText" value="${data.MENUID}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">父级菜单</td>
			<td width="20%" ><select name="PARENTID" id="PARENTID" data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${menuList}">
						<option value="${item.ID}" <c:if test="${item.ID==data.PARENTID}">selected</c:if> >${item.MENUNAME}</option>
				</c:forEach>
			</select></td>
			<td width="10%" align="right" valign="top" class="font14">排序</td>
			<td width="20%" ><input type="text" name='SEQ' data-rule="required;integer;length[~2]" class="inputText" value="${data.SEQ}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">地址</td>
			<td width="20%" ><input type="text" name='URL' id="URL" data-rule="required" class="inputText" value="${data.URL}"/></td>
		</tr>
	</c:if>
	<c:if test="${param.level == '2' }">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">菜单名称</td>
			<td width="20%" ><input type="text" name='MENUNAME' data-rule="required" class="inputText" value="${data.MENUNAME}"/><input type="hidden" name='TYPE' value="2"/></td>
			<td width="10%" align="right" valign="top" class="font14">父级菜单</td>
			<td width="20%" ><select name="PARENTID" id="PARENTID" data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${menuList}">
						<option value="${item.ID}" <c:if test="${item.ID==data.PARENTID}">selected</c:if> >${item.MENUNAME}</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">排序</td>
			<td width="20%" ><input type="text" name='SEQ' data-rule="required;integer;length[~2]" class="inputText" value="${data.SEQ}"/></td>
		</tr>
	</c:if>
	<c:if test="${param.level == '1' }">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">菜单名称</td>
			<td width="20%" ><input type="text" name='MENUNAME' data-rule="required" class="inputText" value="${data.MENUNAME}"/><input type="hidden" name='TYPE' value="1"/></td>
			<td width="10%" align="right" valign="top" class="font14">排序</td>
			<td width="20%" ><input type="text" name='SEQ' data-rule="required;integer;length[~2]" class="inputText" value="${data.SEQ}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">样式</td>
			<td width="20%" ><input type="text" name='CLASS' data-rule="required" class="inputText" value="${data.CLASS}"/></td>
		</tr>
	</c:if>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
