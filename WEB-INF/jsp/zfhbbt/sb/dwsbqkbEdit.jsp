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
	<script type="text/javascript">
		$(function(){
			$("#dwjbqkTable :text").keyup(function(){
				var numArray=[];
				$("#dwjbqkTable .inputText").each(function(i, item){
					if(isNaN(item.value) || parseInt(item.value)<Number(item.value)){
						numArray[i]=0;
					}else{
						numArray[i]=Number(item.value);
					}					
				});
				
				$("#BZRS_CJ").val(numArray[1]+numArray[2]);
				$("#BZRS_KJ").val(numArray[3]+numArray[4]);
				$("#BZRS_HJ").val(numArray[0]+Number($("#BZRS_CJ").val())+Number($("#BZRS_KJ").val())+numArray[5]);
				
				$("#SYRS_CJ").val(numArray[7]+numArray[8]);
				$("#SYRS_KJ").val(numArray[9]+numArray[10]);
				$("#SYRS_HJ").val(numArray[6]+Number($("#SYRS_CJ").val())+Number($("#SYRS_KJ").val())+numArray[11]);
			});
		});	
		function doSubmit(){
			$(":text").each(function(){
				if($(this).val() == ""){
					$(this).val(0);
				}	
			});
			validSubmit(function(d){
				 showSuccessMsg("保存成功");
				 doCancel();
			})
		}
	</script>
</head>
<style>
	table{
		border-collapse: collapse; 
		border-style: solid;
		border-color: #848484;
		font-size: 16px;
	}
	tr{ text-align:center; height: 33px;}
	td{border:1px solid #848484;}
	.span{
		padding-right: 30px;
		font-size:16px;
	}
	input[type="text"]{
		text-align: center;
		padding-left: 0PX;
	}
	.textHidden{
		border: none;
		width: 35px;
		font-size: 16px;
		font-family: Arial;
		color: #333333;
	}
</style>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<center>
	<div class="whiteBox actionArea">
		<span class="span">填报单位：${data.DWMC}</span>
		<span class="span">申报年度：${data.SBND}</span>
		<span class="span">单位经费来源：
			<c:forEach var="item" items="${STD_LIST.dw_jfly}">
				<c:if test="${item.VALUE==data.DWJFLY}">
					${item.TEXT}
				</c:if>
			</c:forEach></span>
	</div>	

<form id="validForm" action="sb/saveDwsbqkb" method="post">
	<input type="hidden" name='DWSBID' value="${data.DWSBID}"/>
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
	    <td><input type="text" name='SND_HJ_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_HJ_RS}"/></td>
	    <td><input type="text" name='SND_HJ_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_HJ_JE}"/></td>
	    <td>${data.BND_HJ_RS}</td>
	    <td>${data.BND_HJ_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">全额领取住房补贴情况</td>
	    <td>2</td>
	    <td><input type="text" name='SND_QE_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_RS}"/></td>
	    <td><input type="text" name='SND_QE_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_JE}"/></td>
	    <td>${data.BND_QE_RS}</td>
	    <td>${data.BND_QE_JE}</td>
	  </tr>
	  <tr>
	    <td width="30" rowspan="4" scope="row">其中</td>
	    <td width="280">租用公有住房</td>
	    <td>3</td>
	    <td><input type="text" name='SND_QE_ZYGY_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYGY_RS}"/></td>
	    <td><input type="text" name='SND_QE_ZYGY_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYGY_JE}"/></td>
	    <td>${data.BND_QE_ZYGY_RS}</td>
	    <td>${data.BND_QE_ZYGY_JE}</td>
	  </tr>
	  <tr>
	    <td>租用其他住房</td>
	    <td>4</td>
	    <td><input type="text" name='SND_QE_ZYQT_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYQT_RS}"/></td>
	    <td><input type="text" name='SND_QE_ZYQT_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYQT_JE}"/></td>
	    <td>${data.BND_QE_ZYQT_RS}</td>
	    <td>${data.BND_QE_ZYQT_JE}</td>
	  </tr>
	  <tr>
	    <td>已购买商品房</td>
	    <td>5</td>
	    <td><input type="text" name='SND_QE_GMSP_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_GMSP_RS}"/></td>
	    <td><input type="text" name='SND_QE_GMSP_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_GMSP_JE}"/></td>
	    <td>${data.BND_QE_GMSP_RS}</td>
	    <td>${data.BND_QE_GMSP_JE}</td>
	  </tr>
	  <tr>
	    <td>自有私房</td>
	    <td>6</td>
	    <td><input type="text" name='SND_QE_ZYSF_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYSF_RS}"/></td>
	    <td><input type="text" name='SND_QE_ZYSF_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_QE_ZYSF_JE}"/></td>
	    <td>${data.BND_QE_ZYSF_RS}</td>
	    <td>${data.BND_QE_ZYSF_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">领取住房面积差额补贴</td>
	    <td>7</td>
	    <td><input type="text" name='SND_CE_RS' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_CE_RS}"/></td>
	    <td><input type="text" name='SND_CE_JE' data-rule="integer" class="inputText" style="width:80px;" value="${data.SND_CE_JE}"/></td>
	    <td>${data.BND_CE_RS}</td>
	    <td>${data.BND_CE_JE}</td>
	  </tr>
	  <tr>
	    <td colspan="2" scope="row">不领取住房补贴情况</td>
	    <td>8</td>
	    <td colspan="2"><input type="text" name='SND_BL_RS' data-rule="integer" class="inputText" value="${data.SND_BL_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_RS' data-rule="integer" class="inputText" value="${data.BND_BL_RS}"/></td>
	  </tr>
	  <tr>
	    <td width="30" rowspan="6" scope="row">其中</td>
	    <td width="280" >已购公有住房（达标）</td>
	    <td>9</td>
	    <td colspan="2"><input type="text" name='SND_BL_YGGYDB_RS' data-rule="integer" class="inputText" value="${data.SND_BL_YGGYDB_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_YGGYDB_RS' data-rule="integer" class="inputText" value="${data.BND_BL_YGGYDB_RS}"/></td>
	  </tr>
	  <tr>
	    <td>已购补贴出售住宅（达标）</td>
	    <td>10</td>
	    <td colspan="2"><input type="text" name='SND_BL_YGBTDB_RS' data-rule="integer" class="inputText" value="${data.SND_BL_YGBTDB_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_YGBTDB_RS' data-rule="integer" class="inputText" value="${data.BND_BL_YGBTDB_RS}"/></td>
	  </tr>
	  <tr>
	    <td>已领足差额面积货币补贴</td>
	    <td>11</td>
	    <td colspan="2"><input type="text" name='SND_BL_YLZCE_RS' data-rule="integer" class="inputText" value="${data.SND_BL_YLZCE_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_YLZCE_RS' data-rule="integer" class="inputText" value="${data.BND_BL_YLZCE_RS}"/></td>
	  </tr>
	  <tr>
	    <td>租住公有住房</td>
	    <td>12</td>
	    <td colspan="2"><input type="text" name='SND_BL_ZZGY_RS' data-rule="integer" class="inputText" value="${data.SND_BL_ZZGY_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_ZZGY_RS' data-rule="integer" class="inputText" value="${data.BND_BL_ZZGY_RS}"/></td>
	  </tr>
	  <tr>
	    <td>租住其他住房</td>
	    <td>13</td>
	    <td colspan="2"><input type="text" name='SND_BL_ZZQT_RS' data-rule="integer" class="inputText" value="${data.SND_BL_ZZQT_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_ZZQT_RS' data-rule="integer" class="inputText" value="${data.BND_BL_ZZQT_RS}"/></td>
	  </tr>
	  <tr>
	    <td>已领取单位货币或建材补助</td>
	    <td>14</td>
	    <td colspan="2"><input type="text" name='SND_BL_YLDWBZ_RS' data-rule="integer" class="inputText" value="${data.SND_BL_YLDWBZ_RS}"/></td>
	    <td colspan="2"><input type="text" name='BND_BL_YLDWBZ_RS' data-rule="integer" class="inputText" value="${data.BND_BL_YLDWBZ_RS}"/></td>
	  </tr>
	</table>
	<table id="dwjbqkTable" width="788" border="1">
	  <tr>
	    <td width="30" rowspan="7" scope="col">单位基本情况</td>
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
	    <td>现行编制共<input type="text" name='BZRS_HJ' id="BZRS_HJ" value="${data.BZRS_HJ}" class="textHidden" readOnly/>名</td>
	    <td><input type="text" name='BZRS_TJ' id="BZRS_TJ" data-rule="integer" class="inputText" style="width:40px;" value="${data.BZRS_TJ}"/></td>
	    <td><input type="text" name='BZRS_CJ' id="BZRS_CJ" value="${data.BZRS_CJ}" class="textHidden" readOnly/></td>
	    <td><input type="text" name='BZRS_CJ_ZW' id="BZRS_CJ_ZW" data-rule="integer" class="inputText" style="width:40px;" value="${data.BZRS_CJ_ZW}"/></td>
	    <td><input type="text" name='BZRS_CJ_GJZC' id="BZRS_CJ_GJZC" data-rule="integer" class="inputText" style="width:40px;" value="${data.BZRS_CJ_GJZC}"/></td>
	    <td><input type="text" name='BZRS_KJ' id="BZRS_KJ" value="${data.BZRS_KJ}" class="textHidden" readOnly/></td>
	    <td><input type="text" name='BZRS_KJ_ZW' id="BZRS_KJ_ZW" data-rule="integer" class="inputText" style="width:40px;" value="${data.BZRS_KJ_ZW}"/></td>
	    <td><input type="text" name='BZRS_KJ_ZJZC' id="BZRS_KJ_ZJZC" data-rule="integer" class="inputText" style="width:40px;" value="${data.BZRS_KJ_ZJZC}"/></td>
	    <td><input type="text" name='BZRS_YBGB' id="BZRS_YBGB" data-rule="integer" class="inputText" style="width:80px;" value="${data.BZRS_YBGB}"/></td>
	  </tr>
	  <tr>
	    <td>实有人数共<input type="text" name='SYRS_HJ' id="SYRS_HJ" value="${data.SYRS_HJ}" class="textHidden" readOnly/>人</td>
	    <td><input type="text" name='SYRS_TJ' id="SYRS_TJ" data-rule="integer" class="inputText" style="width:40px;" value="${data.SYRS_TJ}"/></td>
	    <td><input type="text" name='SYRS_CJ' id="SYRS_CJ" value="${data.SYRS_CJ}" class="textHidden" readOnly/></td>
	    <td><input type="text" name='SYRS_CJ_ZW' id="SYRS_CJ_ZW" data-rule="integer" class="inputText" style="width:40px;" value="${data.SYRS_CJ_ZW}"/></td>
	    <td><input type="text" name='SYRS_CJ_GJZC' id="SYRS_CJ_GJZC" data-rule="integer" class="inputText" style="width:40px;" value="${data.SYRS_CJ_GJZC}"/></td>
	    <td><input type="text" name='SYRS_KJ' id="SYRS_KJ" value="${data.SYRS_KJ}" class="textHidden" readOnly/></td>
	    <td><input type="text" name='SYRS_KJ_ZW' id="SYRS_KJ_ZW" data-rule="integer" class="inputText" style="width:40px;" value="${data.SYRS_KJ_ZW}"/></td>
	    <td><input type="text" name='SYRS_KJ_ZJZC' id="SYRS_KJ_ZJZC" data-rule="integer" class="inputText" style="width:40px;" value="${data.SYRS_KJ_ZJZC}"/></td>
	    <td><input type="text" name='SYRS_YBGB' id="SYRS_YBGB" data-rule="integer" class="inputText" style="width:80px;" value="${data.SYRS_YBGB}"/></td>
	  </tr>
	  <tr>
	    <td colspan="9" align="left">&nbsp;&nbsp;<span class="span">注：1、①=②+③+⑥+⑨</span><span class="span">2、③=④+⑤</span>3、⑥=⑦+⑧</td>
	  </tr>
	</table>
</form>
</center>
<div class="bottomButton">
	<input type="button" name="Submit" id="Submit" value="保存" class="button redButton" onclick="doSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</div>
</body>
</html>
