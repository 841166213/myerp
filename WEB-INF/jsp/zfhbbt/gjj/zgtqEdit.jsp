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
	$(function(){
		if($("#SQLY").val() == '7'){
			$("#SQLY_QT").prop("disabled",false);
		}else{
			$("#SQLY_QT").prop("disabled",true);
		}
		
		$("#SQLY").change(function(){
			if($(this).val() == '7'){
				$("#SQLY_QT").prop("disabled",false);
			}else{
				$("#SQLY_QT").val("");
				$("#SQLY_QT").prop("disabled",true);
			}
		});
	});
	</script>
</head>
<style>
	.span{padding-right: 30px;}
</style>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<form id="validForm" action="gjj/zgtqSave" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">申报单位名称</td>
			<td width="20%" ><select name='DWID' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.jgdw }">
					<option value="${item.VALUE}" <c:if test="${item.VALUE == data.DWID}">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">职工姓名</td>
			<td width="20%"><input type="text" name='XM' data-rule="required" class="inputText" value="${data.XM}"/></td>
			<td width="10%" align="right" valign="top" class="font14">身份证号码</td>
			<td width="20%" ><input type="text" name='SFZHM' data-rule="required" class="inputText" value="${data.SFZHM}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">住房货币补贴开户银行</td>
			<td width="20%" colspan="3" scope="col"><input type="text" name='KHYH' data-rule="required" class="inputText" size="90" value="${data.KHYH}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">个人住房货币补贴账号</td>
			<td width="20%"><input type="text" name='BTZH' data-rule="required" class="inputText" value="${data.BTZH}"/></td>
			<td width="10%" align="right" valign="top" class="font14">个人账户余额</td>
			<td width="20%" ><input type="text" name='ZHYE' data-rule="required;zhye" data-rule-zhye="[/^(([1-9]\d*)|([1-9]\d*\.\d*|0\.\d*[1-9]\d*))$/,'请输入数值']" class="inputText" value="${data.ZHYE}"/></td>
			
		</tr>
		
		<tr>
			<td width="10%" align="right" valign="top" class="font14">联系人</td>
			<td width="20%" ><input type="text" name='LXR' data-rule="required" class="inputText" value="${data.LXR}"/></td>
			<td width="10%" align="right" valign="top" class="font14">联系电话</td>
			<td width="20%" ><input type="text" name='LXDH' data-rule="required" class="inputText" value="${data.LXDH}"/></td>
		</tr>
		<tr>
			
			<td width="10%" align="right" valign="top" class="font14">申请原因</td>
			<td width="20%" colspan="5" scope="col"><span class="span"><select name='SQLY' id="SQLY" data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.zg_sqly }">
					<option value="${item.VALUE }" <c:if test="${item.VALUE == data.SQLY}">selected</c:if>>${item.TEXT}</option>
				</c:forEach>
			</select></span><input type="text" name='SQLY_QT' id="SQLY_QT" data-rule="required" class="inputText" placeholder="其他理由" value="${data.SQLY_QT}" disabled/></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</div>
</body>
</html>
