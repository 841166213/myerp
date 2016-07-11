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
<style>
	table{
		border-collapse: collapse; 
		border-width: thin; 
		border: solid #FFF;
		width: 95%;
	}
	td{border: solid #FFF; color: #333;}
	.td1{background-color: #eaedef;font-size:14px; color:#808080; text-align: -webkit-right;}
	.td2{background-color: #F8F8F8;font-size:14px; color:#808080; text-align: -webkit-left;}
</style>
<body style="background: none;">
<center>
<div style="margin:30px;">
	<table class="formTable">
		<tr>
			<td width="25%" class="td1">单位名称</td>
			<td colspan="3" scope="col" class="td2">${STD_MAP.jgdw[data.DWID]}</td>
		</tr>
		<tr>
			<td class="td1">职工姓名</td>
			<td width="20%" class="td2">${data.XM}</td>
			<td width="15%" class="td1">身份证号码</td>
			<td width="20%" class="td2">${data.SFZHM}</td>
		</tr>
		<tr>
			<td class="td1">住房货币补贴开户银行</td>
			<td colspan="3" scope="col" class="td2">${data.KHYH}</td>
		</tr>
		<tr>
			<td class="td1">个人住房货币补贴账号</td>
			<td class="td2">${data.BTZH}</td>
			<td class="td1">个人账户余额</td>
			<td class="td2">${data.ZHYE}</td>
		</tr>
		<tr>
			<td class="td1">联系人</td>
			<td class="td2">${data.LXR}</td>
			<td class="td1">联系电话</td>
			<td class="td2">${data.LXDH}</td>
		</tr>
		<tr>
			<td class="td1">申请理由</td>
			<td colspan="3" scope="col" class="td2">
				<c:if test="${data.SQLY == 7}">${data.SQLY_QT}</c:if>
				<c:if test="${data.SQLY != 7}">${STD_MAP.dw_zhbgyy[data.SQLY]}</c:if></td>
		</tr>
	</table>
</div>
</center>
</body>
</html>
