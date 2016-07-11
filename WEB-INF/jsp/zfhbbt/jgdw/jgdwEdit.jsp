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
<script type="text/javascript">
function doSubmit(){
	validSubmit(function(d){
		 showSuccessMsg("保存成功");
		 parentCancelReload();
		 getIndexWindow().initStd();
	})
}
</script>
<body style="background: none;">
<form id="validForm" action="jgdw/save" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位名称</td>
			<td width="20%" ><input type="text" name='DWMC' class="inputText" data-rule="required" value="${data.DWMC}"/></td>
			<td width="10%" align="right" valign="top" class="font14">组织机构代码</td>
			<td width="20%" ><input type="text" name='ZZJGDM' class="inputText" value="${data.ZZJGDM}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位性质</td>
			<td width="20%" ><select name='DWXZ'>
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_dwxz }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.DWXZ }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
			<td width="10%" align="right" valign="top" class="font14">单位经费来源</td>
			<td width="20%" ><select name='DWJFLY'>
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.dw_jfly }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.DWJFLY }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位法人代码</td>
			<td width="20%" ><input type="text" name='DWFRDM' class="inputText" value="${data.DWFRDM}"/></td>
			<td width="10%" align="right" valign="top" class="font14">所属区县</td>
			<td width="20%" ><select name='SSQX'>
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.stqx }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.SSQX }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位所在地址</td>
			<td width="20%" ><input type="text" name='DWSZDZ' class="inputText" value="${data.DWSZDZ}"/></td>
			<td width="10%" align="right" valign="top" class="font14">邮政编码</td>
			<td width="20%" ><input type="text" name='YZBM' class="inputText" data-rule="length[6]" value="${data.YZBM}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">主管部门</td>
			<td width="20%" ><input type="text" name='ZGBM' class="inputText" value="${data.ZGBM}"/></td>
			<td width="10%" align="right" valign="top" class="font14">账户名称</td>
			<td width="20%" ><input type="text" name='ZHMC' class="inputText" value="${data.ZHMC}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">开户银行</td>
			<td width="20%" ><input type="text" name='KHYH' class="inputText" value="${data.KHYH}"/></td>
			<td width="10%" align="right" valign="top" class="font14">银行账号</td>
			<td width="20%" ><input type="text" name='YHZH' class="inputText" value="${data.YHZH}"/></td>
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
