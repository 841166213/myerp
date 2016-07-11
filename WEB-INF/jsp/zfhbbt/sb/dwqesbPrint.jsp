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
    <title>发放住房补贴职工情况明细表打印</title>
    <link href="css/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
<script>
	$(function(){
		var table =document.getElementById("mainTable");
		var rows = table.rows.length;
		var colums = table.rows[0].cells.length;
		var sum = 0;//发放额合计
		for(i=1;i<rows-1;i++){
			sum+=Number(table.rows[i].cells[12].innerHTML);
		}
		$("#sum").text(sum);
		if(rows<22){//添加空行
			for(var i=rows-1;i<21;i++){
				var tr=table.insertRow(i);
				for(var j=0;j<colums;j++){
					var td=tr.insertCell(); 
					td.innerHTML="&nbsp;";
				}
			}
		}
	});
</script>
</head>
<style>
html body{background-color: #FFFFFF;}
.mainTable{
		border-collapse: collapse; 
		border-style: solid;
		border-color: black;
		font-family: "宋体";
		font-size: 12px;
		line-height: 18px;
		text-align: center;
	}
	.mainTable td{border:1px solid black;height: 24px;}
	.smallSize {
		font-size: 12px;
		font-family: "宋体";
	}
	.bigSize {
		font-size: 30px;
		font-weight: bold;
		font-family: "宋体";
	}
	span{margin-left: 71px;margin-left: 66px \9;}
	@media print { .redButton { display: none; }}
</style>
<body>
<center>
<table width="1300" style="margin:7px 15px;">
  <tr>
    <td colspan="10" align="center" class="bigSize">发放住房补贴职工情况明细表</td>
  </tr>
  <tr class="smallSize">
    <td width="6%">&nbsp;填报单位：</td>
    <td width="64%" align="left">${STD_MAP.jgdw[dwsb.DWID]}</td>
    <td width="6%" align="right">填报日期：</td>
    <td width="4%" align="center">${dwsb.YEAR}</td>
    <td width="1%">年</td>
    <td width="4%" align="center">${dwsb.MONTH}</td>
    <td width="1%">月</td>
    <td width="4%" align="center">${dwsb.DAY}</td>
    <td width="1%">日</td>
    <td width="10%" align="center">单位：元</td>
  </tr>
  <tr>
    <td colspan="10"><table width="100%" id="mainTable" class="mainTable">
      <tr>
        <td width="6%">姓&nbsp;&nbsp;名</td>
        <td width="11%">身 份 证 号 码</td>
        <td width="5%">参加工作<br />
          时&nbsp; 间</td>
        <td width="6%">进入机关事业<br />
          单位工作时间</td>
        <td width="4%">职务<br />
  (职称)</td>
        <td width="8%">居住情况</td>
        <td width="14%">现 居 住 房 屋 地 址</td>
        <td width="5%">开始领取<br />
          时&nbsp; 间</td>
        <td width="4%">已领取<br />
          年 数</td>
        <td width="5%">上年度月<br />
          发放标准</td>
        <td width="5%">本年度月<br />
发放标准</td>
        <td width="5%">本年度领<br />
          取方式</td>
        <td width="6%">本年发放额<br />
          合计（元）</td>
        <td width="5%">配 偶<br />
          姓 名</td>
        <td width="11%">身 份 证 号 码</td>
      </tr>
      <c:forEach items="${data}" var="item">
	      <tr>
	        <td>${item.XM}</td>
	        <td>${item.SFZHM}</td>
	        <td>${item.CJGZSJ}</td>
	        <td>${item.JRJGSYDWGZSJ}</td>
	        <td>${item.ZW}</td>
	        <td>${STD_MAP.sb_jzqk[item.JZQK]}</td>
	        <td>${item.XJZFWDZ}</td>
	        <td>${item.KSLQSJ}</td>
	        <td>${item.YLQNS}</td>
	        <td>${item.SNDYFFBZ}</td>
	        <td>${item.BNDYFFBZ}</td>
	        <td>${STD_MAP.sb_lqfs[item.LQFS]}</td>
	        <td>${item.FFEHJ}</td>
	        <td>${item.POXM}</td>
	        <td>${item.POSFZHM}</td>
	      </tr>
      </c:forEach>
      <tr>
        <td>合计</td>
        <td>————</td>
        <td>——</td>
        <td>——</td>
        <td>——</td>
        <td>——</td>
        <td>————</td>
        <td>——</td>
        <td>——</td>
        <td>——</td>
        <td>——</td>
        <td>——</td>
        <td id="sum"></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="10" class="smallSize" align="left">&nbsp;填表说明：一、“居住情况”指下列情况：①租用单位住房；②租用房管直管公房；③租用其他住房（含租用私房和其它出租屋，及寄居亲朋的房屋）；④已购买商品住房；⑤自有私房。<br />
     <span>二、首年申领人员，有行政职务的提供任职文件复印件，有技术职务的提供资格证和聘书复印件，领取方式为一次性领取的提供购房合同复印件。</span><br />
     <span>三、按下边分类，每类人员集中填写在一张明细表中。行政职务（含一般干部职工）为一类，专业技术职务的为一类。</span><br />
     <span>四、此表随《单位发放住房补贴审核表》一并使用，一式6份，申报单位和审核审批单位、公积金管理中心、开户银行各存一份。</span></td>
  </tr>
</table>
</center>
<input type="button" name="print" value="打印" class="button redButton" style="position:fixed;bottom:10px;right:70px;" onclick="window.print()"/>	
</body>
</html>
