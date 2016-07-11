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
</script>  
<body style="background: none;">
<form id="validForm" action="system/user/save" method="post">
<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="100px" align="right" valign="top" class="font14">账号</td>
			<td valign="top"><input type="text" name='ACCOUNT' data-rule="required;<c:if test="${data.ID == null}">remote[system/user/checkAccountRepeat]</c:if>" class="inputText" value="${data.ACCOUNT}" <c:if test="${data.ID != null}">disabled</c:if>/></td>
		</tr>
		<tr>
			<td width="100px" align="right" valign="top" class="font14">密码</td>
			<td valign="top"><input type="text" name='PASSWORD' data-rule="required" class="inputText" value="${data.PASSWORD}"/></td>
		</tr>
	</table>
</form>
<!-- content -->
<div class="bottomButton">
	<input type="button"  value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button"  value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
