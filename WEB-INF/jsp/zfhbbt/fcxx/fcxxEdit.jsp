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
<form id="validForm" action="fcxx/save" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">姓名</td>
			<td width="20%" ><input type="text" name='XM' class="inputText" data-rule="required"  value="${data.XM}"/></td>
			<td width="10%" align="right" valign="top" class="font14">身份证</td>
			<td width="20%" ><input type="text" name='SFZ' class="inputText" data-rule="required" value="${data.SFZ}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">配偶姓名</td>
			<td width="20%" ><input type="text" name='POXM' class="inputText" data-rule="required" value="${data.POXM}"/></td></td>
			<td width="10%" align="right" valign="top" class="font14">配偶身份证</td>
			<td width="20%" ><input type="text" name='POSFZ' class="inputText" data-rule="required" value="${data.POSFZ}"/></td></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位</td>
			<td width="20%" ><input type="text" name='DW' class="inputText" data-rule="required" value="${data.DW}"/></td>
			<td width="10%" align="right" valign="top" class="font14">面积（m<sup>2</sup>）</td>
			<td width="20%" ><input type="text" name='MJ' class="inputText" data-rule="required;mj" data-rule-mj="[/^(([1-9]\d*)|([1-9]\d*\.\d*|0\.\d*[1-9]\d*))$/,'请输入数值']" value="${data.MJ}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">地址</td>
			<td width="20%" ><input type="text" name='DZ' class="inputText" data-rule="required" value="${data.DZ}"/></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
