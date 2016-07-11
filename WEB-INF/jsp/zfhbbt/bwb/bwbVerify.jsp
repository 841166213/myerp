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
function doVerify(ID){
	var SHYJ_BWB = $("#SHYJ_BWB").val();
	layer.confirm("是否审核通过？",function(index){
		myAjax({ url: "bwb/bwbPass", 
			data: {ID: ID, SHYJ_BWB: SHYJ_BWB},
			success: function(result){
				showSuccessMsg("审核成功");
				parentCancelReload();
			}
		});
		layer.close(index);
	});
}
</script>
<style>
	table{
		border-collapse: collapse; 
		border-style: solid;
		border-color: #848484;
		font-size: 16px;
	}
	tr{ text-align:center; height: 33px;}
	td{border:1px solid #848484;}
	span{
		padding-right: 30px;
		font-size:16px;
	}
</style>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<center>
	<div class="whiteBox actionArea">
		<span>填报单位：${data.DWMC}</span>
		<span>申报年度：${data.SBND}</span>
		<span>单位经费来源：
			<c:forEach var="item" items="${STD_LIST.dw_jfly}">
				<c:if test="${item.VALUE==data.DWJFLY}">
					${item.TEXT}
				</c:if>
			</c:forEach></span>
	</div>	
		
	<table width="788" border="1">
	  <tr>
	    <td height="114" colspan="2" rowspan="2" align="left" scope="col" style="background-image:url('images/tableLine1.png'); background-repeat:no-repeat;"><p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发补贴情况<br />
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 类别</p></td>
	    <td width="30" rowspan="2" scope="col">序号</td>
	  	<td colspan="2" scope="col"><p>上年度<br />
	    发放住房补贴情况</p></td>
	    <td colspan="2" scope="col"><p>本年度<br />
	    发放住房补贴情况</p></td>
	  </tr>
	  <tr>
	    <td width="100">人数（人）</td>
	    <td width="100">金额（元）</td>
	    <td width="100">人数（人）</td>
	    <td width="100">金额（元）</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">合计</td>
	    <td>1</td>
	    <td>${data.SND_HJ_RS}</td>
	    <td>${data.SND_HJ_JE}</td>
	    <td>${data.BND_HJ_RS}</td>
	    <td>${data.BND_HJ_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">全额领取住房补贴情况</td>
	    <td>2</td>
	    <td>${data.SND_QE_RS}</td>
	    <td>${data.SND_QE_JE}</td>
	    <td>${data.BND_QE_RS}</td>
	    <td>${data.BND_QE_JE}</td>
	  </tr>
	  <tr>
	    <td width="30" rowspan="4" scope="row">其中</td>
	    <td width="280">租用公有住房</td>
	    <td>3</td>
	    <td>${data.SND_QE_ZYGY_RS}</td>
	    <td>${data.SND_QE_ZYGY_JE}</td>
	    <td>${data.BND_QE_ZYGY_RS}</td>
	    <td>${data.BND_QE_ZYGY_JE}</td>
	  </tr>
	  <tr>
	    <td>租用其他住房</td>
	    <td>4</td>
	    <td>${data.SND_QE_ZYQT_RS}</td>
	    <td>${data.SND_QE_ZYQT_JE}</td>
	    <td>${data.BND_QE_ZYQT_RS}</td>
	    <td>${data.BND_QE_ZYQT_JE}</td>
	  </tr>
	  <tr>
	    <td>已购买商品房</td>
	    <td>5</td>
	    <td>${data.SND_QE_GMSP_RS}</td>
	    <td>${data.SND_QE_GMSP_JE}</td>
	    <td>${data.BND_QE_GMSP_RS}</td>
	    <td>${data.BND_QE_GMSP_JE}</td>
	  </tr>
	  <tr>
	    <td>自有私房</td>
	    <td>6</td>
	    <td>${data.SND_QE_ZYSF_RS}</td>
	    <td>${data.SND_QE_ZYSF_JE}</td>
	    <td>${data.BND_QE_ZYSF_RS}</td>
	    <td>${data.BND_QE_ZYSF_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">领取住房面积差额补贴</td>
	    <td>7</td>
	    <td>${data.SND_CE_RS}</td>
	    <td>${data.SND_CE_JE}</td>
	    <td>${data.BND_CE_RS}</td>
	    <td>${data.BND_CE_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">不领取住房补贴情况</td>
	    <td>8</td>
	    <td colspan="2">${data.SND_BL_RS}</td>
	    <td colspan="2">${data.BND_BL_RS}</td>
	  </tr>
	  <tr>
	    <td width="30" rowspan="6" scope="row">其中</td>
	    <td width="280" >已购公有住房（达标）</td>
	    <td>9</td>
	    <td colspan="2">${data.SND_BL_YGGYDB_RS}</td>
	    <td colspan="2">${data.BND_BL_YGGYDB_RS}</td>
	  </tr>
	  <tr>
	    <td>已购补贴出售住宅（达标）</td>
	    <td>10</td>
	    <td colspan="2">${data.SND_BL_YGBTDB_RS}</td>
	    <td colspan="2">${data.BND_BL_YGBTDB_RS}</td>
	  </tr>
	  <tr>
	    <td>已领足差额面积货币补贴</td>
	    <td>11</td>
	    <td colspan="2">${data.SND_BL_YLZCE_RS}</td>
	    <td colspan="2">${data.BND_BL_YLZCE_RS}</td>
	  </tr>
	  <tr>
	    <td>租住公有住房</td>
	    <td>12</td>
	    <td colspan="2">${data.SND_BL_ZZGY_RS}</td>
	    <td colspan="2">${data.BND_BL_ZZGY_RS}</td>
	  </tr>
	  <tr>
	    <td>租住其他住房</td>
	    <td>13</td>
	    <td colspan="2">${data.SND_BL_ZZQT_RS}</td>
	    <td colspan="2">${data.BND_BL_ZZQT_RS}</td>
	  </tr>
	  <tr>
	    <td>已领取单位货币或建材补助</td>
	    <td>14</td>
	    <td colspan="2">${data.SND_BL_YLDWBZ_RS}</td>
	    <td colspan="2">${data.BND_BL_YLDWBZ_RS}</td>
	  </tr>
	</table>
	<table width="788" border="1">
	  <tr>
	    <td width="30" rowspan="6" scope="col">单位基本情况</td>
	    <td height="114" width="220" rowspan="2" align="left" scope="col" style="background-image:url('images/tableLine2.png'); background-repeat:no-repeat;"><p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中<br />
	    &nbsp;&nbsp;人员情况合计</p></td>
	    <td width="54" rowspan="2" scope="col"><p>厅级<br />
	    （人）</p></td>
	    <td colspan="3" scope="col">处级（人）</td>
	    <td colspan="3" scope="col">科级（人）</td>
	    <td width="100" scope="col">一般干部</td>
	  </tr>
	  <tr>
	    <td width="54">小计</td>
	    <td width="53">职务</td>
	    <td width="53"><p align="center">高级<br />
	    职称</p></td>
	    <td width="53">小计</td>
	    <td width="53">职务</td>
	    <td width="53">中级<br />
	职称</td>
	    <td>工人</td>
	  </tr>
	  <tr>
	    <td>①</td>
	    <td>②</td>
	    <td>③</td>
	    <td>④</td>
	    <td>⑤</td>
	    <td>⑥</td>
	    <td>⑦</td>
	    <td>⑧</td>
	    <td>⑨</td>
	  </tr>
	  <tr>
	    <td>现行编制共&nbsp;&nbsp;${data.BZRS_HJ}&nbsp;&nbsp;名</td>
	    <td>${data.BZRS_TJ}</td>
	    <td>${data.BZRS_CJ}</td>
	    <td>${data.BZRS_CJ_ZW}</td>
	    <td>${data.BZRS_CJ_GJZC}</td>
	    <td>${data.BZRS_KJ}</td>
	    <td>${data.BZRS_KJ_ZW}</td>
	    <td>${data.BZRS_KJ_ZJZC}</td>
	    <td>${data.BZRS_YBGB}</td>
	  </tr>
	  <tr>
	    <td>实有人数共&nbsp;&nbsp;${data.SYRS_HJ}&nbsp;&nbsp;人</td>
	    <td>${data.SYRS_TJ}</td>
	    <td>${data.SYRS_CJ}</td>
	    <td>${data.SYRS_CJ_ZW}</td>
	    <td>${data.SYRS_CJ_GJZC}</td>
	    <td>${data.SYRS_KJ}</td>
	    <td>${data.SYRS_KJ_ZW}</td>
	    <td>${data.SYRS_KJ_ZJZC}</td>
	    <td>${data.SYRS_YBGB}</td>
	  </tr>
	  <tr>
	    <td colspan="9" align="left">&nbsp;&nbsp;<span>注：1、①=②+③+⑥+⑨ 2、③=④+⑤ 3、⑥=⑦+⑧</span></td>
	  </tr>
	</table>
</center>
</div>
<div class="bottomButton">
	<input type="button" name="Submit" value="审核通过" class="button redButton" onclick="doVerify(${data.DWSBID });"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
</body>
</html>
