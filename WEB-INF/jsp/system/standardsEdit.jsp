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
	<script>
		function doSubmit(){
			validSubmit(function(){
				showSuccessMsg("保存成功");
				getIndexWindow().initStd();
				parent.reloadGrid();
				doCancel();
			});
		}
	</script>
</head>
<body style="background: none;">
<form id="validForm" action="system/standards/save" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<c:if test="${param.type != null}">
		<input type="hidden" name="TYPE" value="${param.type}">
	</c:if>
	<c:if test="${param.type == null && data.TYPE != null}">
		<input type="hidden" name="TYPE" value="${data.TYPE}">
	</c:if>
	<table class="formTable">
		<tr>
			<td width="70" align="right" valign="top" class="font14">数值</td>
			<td valign="top"><input type="text" name='VALUE' data-rule="required" class="inputText" value="${data.VALUE}"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">文本</td>
			<td valign="top"><input type="text" name='TEXT' data-rule="required" class="inputText" value="${data.TEXT}"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">排序</td>
			<td valign="top"><input type="text" name='SEQ' data-rule="required;integer" class="inputText" value="${data.SEQ}"/></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
