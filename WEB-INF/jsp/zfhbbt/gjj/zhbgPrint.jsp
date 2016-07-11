<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>
  	<base href="<%=basePath%>">
    <title>汕头市住房货币补贴账户变更登记表打印</title>
    <link href="css/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
<script>
	$(function(){
		var bgq_dwxz = ${data.BGQ_DWXZ};
		$(":checkbox[name='BGQ_DWXZ']").each(function(i, item){
			if(item.value == "${data.BGQ_DWXZ}"){
				item.checked = true;
				return false;
			}
		});
		if(bgq_dwxz != 1 && bgq_dwxz != 2 && bgq_dwxz != 3 && bgq_dwxz != 4 && bgq_dwxz != 8){
			$("#qt").attr("checked", true);
			$("#DWXZ_QT").html("${STD_MAP.sb_dwxz[data.BGQ_DWXZ]}");
		}
		$(":checkbox[name='BGYY']").each(function(i, item){
			if(item.value == "${data.BGYY}"){
				item.checked = true;
				return false;
			}
		});
	});
</script>
</head>
<style>
html body{background-color: #FFFFFF;}
.mainTable{
		border-collapse: collapse; 
		border-style: solid;
		border-color: black;
		font-size: 14px;
		line-height:33px;
		text-align: center;
	}
	.mainTable td{border:1px solid black; height:33px;}
.titleFont {
	font-weight: bold;
	font-size: 26px;
}
.other{font-size: 14px;}
.smallFont {
	font-size: 12px;
}
@media print { .redButton { display: none; }}
</style>
<body>
<center>
<table width="670" style="margin:15px;">
  <tr>
    <td colspan="8" align="center" class="titleFont">汕头市住房货币补贴账户变更登记表</td>
    </tr>
  <tr class="other">
    <td colspan="8">&nbsp;</td>
    </tr>
  <tr class="other">
    <td width="170">&nbsp;申报单位名称（盖章）：</td>
    <td width="332" align="left">${STD_MAP.jgdw[data.DWID]}</td>
    <td width="33" align="center">${data.YEAR}</td>
    <td width="17">年</td>
    <td width="19" align="center">${data.MONTH}</td>
    <td width="17">月</td>
    <td width="19" align="center">${data.DAY}</td>
    <td width="27">日</td>
  </tr>
  <tr>
    <td colspan="8"><table width="100%" border="1" class="mainTable">
      <tr>
        <td width="4%" rowspan="12"><img alt="" src="images/table_sbq.png"></td>
        <td width="17%">组织机构代码</td>
        <td colspan="3">${data.ZZJGDM}</td>
        <td width="14%">所属区县</td>
        <td width="17%">${STD_MAP.stqx[data.SSQX]}</td>
      </tr>
      <tr>
        <td>单位地址</td>
        <td colspan="3">${data.DWSZDZ}</td>
        <td>邮政编码</td>
        <td>${data.YZBM}</td>
      </tr>
      <tr>
        <td>单位性质</td>
        <td colspan="5" align="left" style="position:relative;">
        	<label for="jg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 机关</label>
			<input type="checkbox" id="jg" name="BGQ_DWXZ" value="1" disabled/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
			<label for="sydw">事业单位</label>
			<input type="checkbox" id="sydw" name="BGQ_DWXZ" value="2" disabled/>
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  
			<label for="qy">&nbsp;&nbsp; 企业</label>
			<input type="checkbox" id="qy" name="BGQ_DWXZ" value="3" disabled/><br />
			<label for="shtt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 社会团体</label>
			<input type="checkbox" id="shtt" name="BGQ_DWXZ" value="4" disabled/>
			<label for="qt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 其他</label>
			<input type="checkbox" id="qt" name="BGQ_DWXZ" value="8" disabled/> 
			&nbsp;&nbsp;____________________<span id="DWXZ_QT" style="position:absolute;bottom:6px;right:130px;width:100px;text-align:center;"></span></td></td>
        </tr>
      <tr>
        <td>经办部门</td>
        <td width="23%">${STD_MAP.jgdw[data.JBBM]}</td>
        <td width="10%">经办人</td>
        <td width="15%">${data.JBR}</td>
        <td>联系电话</td>
        <td>${data.JBR_LXDH}</td>
      </tr>
      <tr>
        <td>变更原因</td>
        <td colspan="5" style="position:relative;">
        	<label for="dwgm">单位更名</label>
			<input type="checkbox" id="dwgm" name="BGYY" value="1" disabled/>
			<label for="hb">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 合并</label>
			<input type="checkbox" id="hb" name="BGYY" value="2" disabled/>
			<label for="khyhbg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 开户银行变更</label>
			<input type="checkbox" id="khyhbg" name="BGYY" value="3" disabled/>
			<label for="qt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 其它</label>
			<input type="checkbox" id="qt" name="BGYY" value="4" disabled/>
			&nbsp; _______________<span id="BGYY_QT" style="position:absolute;bottom:6px;right:20px;width:100px;text-align:center;">${data.BGYY_QT}</span></td>
        </tr>
      <tr>
        <td colspan="6">住房货币补贴变更事项及内容</td>
        </tr>
      <tr>
        <td colspan="3">变更前</td>
        <td colspan="3">变更后</td>
        </tr>
      <tr>
        <td>单位性质</td>
        <td colspan="2">${STD_MAP.sb_dwxz[data.BGQ_DWXZ]}</td>
        <td>单位性质</td>
        <td colspan="2">${STD_MAP.sb_dwxz[data.DWXZ]}</td>
        </tr>
      <tr>
        <td>账户名称</td>
        <td colspan="2">${data.BGQ_ZHMC}</td>
        <td>账户名称</td>
        <td colspan="2">${data.ZHMC}</td>
        </tr>
      <tr>
        <td>开户银行</td>
        <td colspan="2">${data.BGQ_KHYH}</td>
        <td>开户银行</td>
        <td colspan="2">${data.KHYH}</td>
        </tr>
      <tr>
        <td>账号</td>
        <td colspan="2">${data.YHZH}</td>
        <td>账号</td>
        <td colspan="2">${data.JBR_LXDH}</td>
        </tr>
      <tr>
        <td colspan="6" align="left" valign="top" style="height:110px;line-height:18px;">申请单位补充说明事项：<br />${data.BCSM}</td>
        </tr>
      <tr>
        <td rowspan="2"><img alt="" src="images/table_shq.png"></td>
        <td>管理中心经办人</td>
        <td colspan="2">${data.GLZXJBR}</td>
        <td>联系电话</td>
        <td colspan="2">${data.GLZXJBR_LXDH}</td>
        </tr>
      <tr>
        <td colspan="6" align="left" valign="top" style="height:180px;line-height:18px;position:relative;">审核意见：<span style="position:absolute;bottom:20px;right:100px;">管理中心盖章</span></td>
        </tr>
    </table></td>
    </tr>
  <tr class="smallFont">
    <td colspan="8" align="left">&nbsp;填表说明：1、属行政事业单位的，须提供编委批准变更相关文件、组织机构代码证（事业单位还须提供事业单位法 人证<br />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 书）原件和复印件；属企业单位的，&nbsp; 须提供工商行政部门批准变更相关文件、营业执照及组织 机构代码证<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 原件和复印件。<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2、本表一式三份，申请单位、承办业务银行、管理中心各一份。</td>
    </tr>
</table>
</center>
<input type="button" name="print" value="打印" class="button redButton" style="position:fixed;bottom:10px;right:70px;" onclick="window.print()"/>	
</body>
</html>
