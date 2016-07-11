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
	<script type="text/javascript" src="js/zfhbbt.js"></script>
	<script>
	function searchHistory(){
		if($('#SFZHM').isValid()){
			myAjax({ url: "sb/getLastRysb", 
				data: {SFZHM: $("#SFZHM").val()},
				success: function(result){
					if(result.data != null){
						$("#validForm").resetForm();
						delete result.data["ID"];
						delete result.data["DWSBID"];
						delete result.data["SBLX"];
						$("#formTable").setForm(result.data);
						$("#YLQNS").val(Number($("#YLQNS").val())+1);
						calculateJe();
					}else{
						layer.msg("该职工未有历史申报信息");
					}
				}
			});
		}
	}
	
	var dyxzzj;//对应行政职级
	function getZwzj(element, param, field){
		var result = "error";
		myAjax({url:"zwzj/getZwzjByZw", data:{ZW: $('#ZW').val()}, async: false, success:function(rs){
				if(rs.data == null){
					result = {'error':'找不到该职务'};
				}else{
					dyxzzj = rs.data.XZZJ;
					$("#XZZJ").val(dyxzzj);
					result = {'ok':'对应：'+rs.data.XZZJMC};
				}
			}
		})
		return result;
	}
	
	function calculateJe(){
		
		var sblx = $("#SBLX").val();
		
		var ZW = $('#ZW');
		var YLQNS = $('#YLQNS');
		var LQFS = $('#LQFS');
		if(!ZW.isValid() || !YLQNS.isValid() || !LQFS.isValid()){
			return
		}
		var lqfs = LQFS.val();
		
		var ylqns = YLQNS.val();
		var bndyffbz = getBNDYFFBZ(dyxzzj, ylqns)
		$('#BNDYFFBZ').val(bndyffbz);
		
		if(sblx == '1'){//全额
			$('#FFEHJ').val(getFFEHJ(sblx, dyxzzj, ylqns, lqfs));
		}
		
		if(sblx == '2'){//差额
			var FGMJ = $('#FGMJ');
			if(!FGMJ.isValid()){
				return
			}
			
			var fgmj = FGMJ.val();
			$('#FFEHJ').val(getFFEHJ(sblx, dyxzzj, ylqns, lqfs, fgmj));
		}
	}
	
	function calculateZe(){
		var ZW = $('#ZW');
		var FGMJ = $('#FGMJ');
		if(!ZW.isValid() || !FGMJ.isValid()){
			return
		}
		var fgmj = FGMJ.val();
		$('#CEHBBTZE').val(getCEHBBTZE(dyxzzj, fgmj));
	}
	</script>
</head>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<form id="validForm" action="sb/saveRysbxx" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<input type="hidden" id="XZZJ" name='XZZJ' value="${data.XZZJ}"/>
	<c:if test="${data.DWSBID != null}">
		<input type="hidden" name='DWSBID' value="${data.DWSBID}"/>
		<input type="hidden" id="SBLX" name='SBLX' value="${data.SBLX}"/>
	</c:if>
	<c:if test="${data.DWSBID == null}">
		<input type="hidden" name='DWSBID' value="${param.dwsbId}"/>
		<input type="hidden" id="SBLX" name='SBLX' value="${param.sblx}"/>
	</c:if>
	<table class="formTable" id="formTable">
		<tr>
			<td width="10%" class="textColumn">身份证号码</td>
			<td width="20%" colspan="3"><input type="text" name='SFZHM' id="SFZHM" data-rule="required;sfz" data-rule-sfz="[/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/, '身份证格式错误']" class="inputText" value="${data.SFZHM}"/>
			<c:if test="${data.DWSBID == null}">
			<input type="button" name="search" value="查询历史申报" class="button" style="margin-left:70px;" onclick="searchHistory();"/>
			</c:if>
			</td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">姓名</td>
			<td width="20%" ><input type="text" name='XM' data-rule="required" class="inputText" value="${data.XM}"/></td>
			<td width="10%" class="textColumn">在职状态</td>
			<td width="20%"><select name='ZZZT' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_zzzt }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.ZZZT }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<c:if test="${param.sblx == '1' or data.SBLX == '1'}">
		<tr>
			<td width="10%" class="textColumn">参加工作时间</td>
			<td width="20%"><input type="text" name='CJGZSJ' data-rule="required" class="laydate-icon inputText" value="${data.CJGZSJ}" onclick="laydate()"/></td>
			<td width="10%" class="textColumn">进入机关事业单位工作时间</td>
			<td width="20%"><input type="text" name='JRJGSYDWGZSJ' data-rule="required" class="inputText laydate-icon" value="${data.JRJGSYDWGZSJ}" onclick="laydate()"/></td>
		</tr>
		</c:if>
		<tr>
			<td width="10%" class="textColumn">职务（职称）</td>
			<td width="20%"><input type="text" id="ZW" name='ZW' data-rule="required;zwzj" data-rule-zwzj="getZwzj" class="inputText" value="${data.ZW}"/></select>
			</td>
			<td width="10%" class="textColumn">居住情况</td>
			<td width="20%"><select name='JZQK' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_jzqk }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.JZQK }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>				
			</select></td>
		</tr>
		<c:if test="${param.sblx == '1' or data.SBLX == '1'}">
		<tr>
			<td width="10%" class="textColumn">现居住房屋地址</td>
			<td width="20%" colspan="3"><input type="text" name='XJZFWDZ' data-rule="required" class="inputText" size="70" value="${data.XJZFWDZ}"/></td>
		</tr>
		</c:if>
		<c:if test="${param.sblx == '2' or data.SBLX == '2'}">
		<tr>
			<td width="10%" class="textColumn">房改面积</td>
			<td width="20%"><input type="text" id="FGMJ" name='FGMJ' data-rule="integer" class="inputText" value="${data.FGMJ}"/></td>
			<td width="10%" class="textColumn">差额货币补贴总额</td>
			<td width="20%"><input type="text" id="CEHBBTZE" name='CEHBBTZE' data-rule="integer" class="inputText" value="${data.CEHBBTZE}"/><input type="button" value="计算" style="margin-left:70px;"  class="button"  onclick="calculateZe()"></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">房屋所在地址</td>
			<td width="20%" colspan="3"><input type="text" name='FWSZDZ' class="inputText" size="70" value="${data.FWSZDZ}"/></td>
		</tr>
		</c:if>
		<tr>
			<td width="10%" class="textColumn">开始领取时间</td>
			<td width="20%"><input type="text" name='KSLQSJ' data-rule="required" class="inputText laydate-icon" value="${data.KSLQSJ}" onclick="laydate()"/></td>
			<td width="10%" class="textColumn">已领取年数</td>
			<td width="20%"><input type="text" id="YLQNS" name='YLQNS' id="YLQNS" data-rule="required;integer" class="inputText" value="${data.YLQNS}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">上年度月发放标准</td>
			<td width="20%"><input type="text" name='SNDYFFBZ' data-rule="required;integer" class="inputText" value="${data.SNDYFFBZ}"/></td>
			<td width="10%" class="textColumn">本年度月发放标准</td>
			<td width="20%"><input type="text" id="BNDYFFBZ" name='BNDYFFBZ' data-rule="required;integer" class="inputText" value="${data.BNDYFFBZ}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">本年度领取方式</td>
			<td width="20%"><select id="LQFS" name='LQFS' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_lqfs }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.LQFS }">selected</c:if>>${item.TEXT }</option>
				</c:forEach></select></td>
			<td width="10%" class="textColumn">本年度发放额合计</td>
			<td width="20%"><input type="text" id="FFEHJ" name='FFEHJ' data-rule="required;integer" class="inputText" value="${data.FFEHJ}"/><input type="button" value="计算" style="margin-left:70px;"  class="button"  onclick="calculateJe()"></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">配偶姓名</td>
			<td width="20%"><input type="text" name='POXM' class="inputText" value="${data.POXM}"/></td>
			<td width="10%" class="textColumn">配偶身份证号码</td>
			<td width="20%"><input type="text" name='POSFZHM' data-rule="sfz" data-rule-sfz="[/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/, '身份证格式错误']" class="inputText" value="${data.POSFZHM}"/></td>
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
