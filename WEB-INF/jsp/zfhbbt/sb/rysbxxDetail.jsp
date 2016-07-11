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
<div style="margin:10px;">
	<table class="formTable">
		<tr>
			<td width="10%" class="td1">身份证号码</td>
			<td width="20%" class="td2">${data.SFZHM}</td>
		</tr>
		<tr>
			<td width="10%" class="td1">姓名</td>
			<td width="18%" class="td2">${data.XM}</td>
			<td width="14%" class="td1">在职状态</td>
			<td width="18%" class="td2">${STD_MAP.sb_zzzt[data.ZZZT]}</td>
		</tr>
		<c:if test="${param.sblx == '1' or data.SBLX == '1'}">
		<tr>
			<td width="10%" class="td1">参加工作时间</td>
			<td width="20%" class="td2">${data.CJGZSJ}</td>
			<td width="10%" class="td1">进入机关事业单位工作时间</td>
			<td width="20%" class="td2">${data.JRJGSYDWGZSJ}</td>
		</tr>
		</c:if>
		<tr>
			<td width="10%" class="td1">职务（职称）</td>
			<td width="20%" class="td2">${data.ZW}</select>
			</td>
			<td width="10%" class="td1">居住情况</td>
			<td width="20%" class="td2">${STD_MAP.sb_jzqk[data.JZQK]}</td>
		</tr>
		<c:if test="${param.sblx == '1' or data.SBLX == '1'}">
		<tr>
			<td width="10%" class="td1">现居住房屋地址</td>
			<td width="20%" colspan="3" class="td2">${data.XJZFWDZ}</td>
		</tr>
		</c:if>
		<c:if test="${param.sblx == '2' or data.SBLX == '2'}">
		<tr>
			<td width="10%" class="td1">房改面积</td>
			<td width="20%" class="td2">${data.FGMJ}</td>
			<td width="10%" class="td1">差额货币补贴总额</td>
			<td width="20%" class="td2">${data.CEHBBTZE}</td>
		</tr>
		<tr>
			<td width="10%" class="td1">房屋所在地址</td>
			<td width="20%" colspan="3" class="td2">${data.FWSZDZ}</td>
		</tr>
		</c:if>
		<tr>
			<td width="10%" class="td1">开始领取时间</td>
			<td width="20%" class="td2">${data.KSLQSJ}</td>
			<td width="10%" class="td1">已领取年数</td>
			<td width="20%" class="td2">${data.YLQNS}</td>
		</tr>
		<tr>
			<td width="10%" class="td1">上年度月发放标准</td>
			<td width="20%" class="td2">${data.SNDYFFBZ}</td>
			<td width="10%" class="td1">本年度月发放标准</td>
			<td width="20%" class="td2">${data.BNDYFFBZ}</td>
		</tr>
		<tr>
			<td width="10%" class="td1">本年度领取方式</td>
			<td width="20%" class="td2">${STD_MAP.sb_lqfs[data.LQFS]}</td>
			<td width="10%" class="td1">本年度发放额合计</td>
			<td width="20%" class="td2">${data.FFEHJ}</td>
		</tr>
		<tr>
			<td width="10%" class="td1">配偶姓名</td>
			<td width="20%" class="td2">${data.POXM}</td>
			<td width="10%" class="td1">配偶身份证号码</td>
			<td width="20%" class="td2">${data.POSFZHM}</td>
		</tr>
	</table>
</div>
</center>
</body>
</html>
