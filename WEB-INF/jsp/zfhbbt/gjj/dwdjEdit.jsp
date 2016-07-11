<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<script type="text/javascript" src="js/laydate/laydate.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
</head>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<form id="validForm" action="gjj/saveDwdj?method=${data.method}" method="post">
	<input type="hidden" name='DWSBID' value="${data.DWSBID}"/>
	<table class="formTable">
		<tr>
			<td width="10%" class="textColumn">单位</td>
			<td width="20%" ><input type="text" name='DWMC' data-rule="required" class="inputText" value="${data.DWMC}" readonly/></td>
			<td width="10%" class="textColumn">法人代码</td>
			<td width="20%" ><input type="text" name='DWFRDM' data-rule="required" class="inputText" value="${data.DWFRDM}" readonly/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">单位地址</td>
			<td width="20%"><input type="text" name='DWSZDZ' data-rule="required" class="inputText" value="${data.DWSZDZ}" readonly/></td>
			<td width="10%" class="textColumn">邮政编码</td>
			<td width="20%" ><input type="text" name='YZBM' data-rule="required" class="inputText" value="${data.YZBM}" readonly/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">主管部门</td>
			<td width="20%"><input type="text" name='ZGBM' data-rule="required" class="inputText" value="${data.ZGBM}" readonly/></td>
			<td width="10%" class="textColumn">单位性质</td>
			<td width="20%"><select name='DWXZ' data-rule="required" readonly>
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_dwxz }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.DWXZ }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">单位住房基金开户银行</td>
			<td width="20%"><input type="text" name='KHYH' data-rule="required" class="inputText" value="${data.KHYH}" readonly/></td>
			<td width="10%" class="textColumn">单位银行账号</td>
			<td width="20%"><input type="text" name='YHZH' data-rule="required" class="inputText" value="${data.YHZH}" readonly/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">汇储总人数</td>
			<td width="20%"><input type="text" name='HCZRS' data-rule="required;integer" class="inputText" value="${data.HCZRS}"/></td>
			<td width="10%" class="textColumn">汇储总金额</td>
			<td width="20%"><input type="text" name='HCZJE' data-rule="required;integer" class="inputText" value="${data.HCZJE}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">登记日期</td>
			<td width="20%"><input type="text" name='DJRQ' data-rule="required" class="laydate-icon inputText" value="${data.DJRQ}" onclick="laydate()"/></td>
			<td width="10%" class="textColumn">第几年</td>
			<td width="20%"><input type="text" name='DJN' data-rule="required;integer" class="inputText" value="${data.DJN}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">经办部门</td>
			<td width="20%"><input type="text" name='JBBM' data-rule="required" class="inputText" value="${data.JBBM}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">负责人</td>
			<td width="20%"><input type="text" name='FZR' data-rule="required" class="inputText" value="${data.FZR}"/></td>
			<td width="10%" class="textColumn">负责人电话</td>
			<td width="20%"><input type="text" name='FZR_DH' data-rule="required" class="inputText" value="${data.FZR_DH}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">联系人</td>
			<td width="20%"><input type="text" name='LXR' data-rule="required" class="inputText" value="${data.LXR}"/></td>
			<td width="10%" class="textColumn">联系人电话</td>
			<td width="20%"><input type="text" name='LXR_DH' data-rule="required" class="inputText" value="${data.LXR_DH}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">住房补贴开户银行</td>
			<td width="20%"><input type="text" name='ZFBTKHYH' data-rule="required" class="inputText" value="${data.ZFBTKHYH}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">经办人</td>
			<td width="20%"><input type="text" name='JBR' class="inputText" value="${data.JBR}"/></td>
			<td width="10%" class="textColumn">经办人电话</td>
			<td width="20%"><input type="text" name='JBR_DH' class="inputText" value="${data.JBR_DH}"/></td>
		</tr>
	</table>
</form>
</div>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
