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
<div style="margin:10px;">
	<table class="formTable">
		<tr>
			<td width="20%" class="td1">申报单位名称</td>
			<td width="20%" colspan="3" scope="col" class="td2">${STD_MAP.jgdw[data.DWID]}</td>
			<td width="10%" class="td1">申报时间</td>
			<td width="20%" colspan="3" scope="col" class="td2">${data.SBSJ}</td>
		</tr>
		<tr>
			<td class="td1">组织机构代码</td>
			<td colspan="3" scope="col" class="td2">${data.ZZJGDM}</td>
			<td class="td1">所属区县</td>
			<td class="td2">${STD_MAP.stqx[data.SSQX]}</td>
		</tr>
		<tr>
			<td class="td1">单位地址</td>
			<td colspan="3" scope="col" class="td2">${data.DWSZDZ}</td>
			<td class="td1">邮政编码</td>
			<td class="td2">${data.YZBM}</td>
		</tr>
		<tr>
			<td class="td1">单位性质</td>
			<td colspan="5" scope="col" class="td2">${STD_MAP.sb_dwxz[data.BGQ_DWXZ]}</td>
		</tr>
		<tr>
			<td class="td1">经办部门</td>
			<td class="td2">${STD_MAP.jgdw[data.JBBM]}</td>
			<td width="10%" class="td1">经办人</td>
			<td width="20%" class="td2">${data.JBR}</td>
			<td class="td1">联系电话</td>
			<td class="td2">${data.JBR_LXDH}</td>
		</tr>
		<tr>
			
			<td class="td1">变更原因</td>
			<td colspan="5" scope="col" class="td2">
				<c:if test="${data.BGYY == 4}">${data.BGYY_QT}</c:if>
				<c:if test="${data.BGYY != 4}">${STD_MAP.dw_zhbgyy[data.BGYY]}</c:if></td>
		</tr>
		<tr class="td1">
			<td colspan="3" scope="col" style="text-align:center;">变更前</td>
			<td colspan="3" scope="col" style="text-align:center;">变更后</td>
		</tr>
		<tr>
			<td class="td1">单位性质</td>
			<td colspan="2" scope="col" class="td2">${STD_MAP.sb_dwxz[data.BGQ_DWXZ]}</td>
			<td class="td1">单位性质</td>
			<td colspan="2" scope="col" class="td2">${STD_MAP.sb_dwxz[data.DWXZ]}</td>
		</tr>
		<tr>
			<td class="td1">账户名称</td>
			<td colspan="2" scope="col" class="td2">${data.BGQ_ZHMC}</td>
			<td class="td1">账户名称</td>
			<td colspan="2" scope="col" class="td2">${data.ZHMC}</td>
		</tr>
		<tr>
			<td class="td1">开户银行</td>
			<td colspan="2" scope="col" class="td2">${data.BGQ_KHYH}</td>
			<td class="td1">开户银行</td>
			<td colspan="2" scope="col" class="td2">${data.KHYH}</td>
		</tr>
		<tr>
			<td class="td1">账号</td>
			<td colspan="2" scope="col" class="td2">${data.BGQ_YHZH}</td>
			<td class="td1">账号</td>
			<td colspan="2" scope="col" class="td2">${data.YHZH}</td>
		</tr>
		<tr>
			<td class="td1">申请单位补充说明事项</td>
			<td colspan="5" style="word-break: break-all;" class="td2">${data.BCSM}</td>
		</tr>
		<tr>
			<td class="td1">管理中心经办人</td>
			<td colspan="2" scope="col" class="td2">${data.ACCOUNT}</td>
			<td class="td1">联系电话</td>
			<td colspan="2" scope="col" class="td2">${data.GLZXJBR_LXDH}</td>
		</tr>
	</table>
</div>
</center>
</body>
</html>
