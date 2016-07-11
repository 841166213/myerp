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
function setZwlb(){
	var zwlb = document.getElementById("ZWLB");
	parent.layer.open({
	      type: 2,
	      title: '职务类别管理',
	      maxmin: true, //开启最大化最小化按钮
	      area: ['80%', '80%'],
	      content: "system/standards/manage?type=zwlb&typename=职务类别",
	      cancel: function(index){
	    	  refreshOptions(STD.zwlb, zwlb, zwlb.value);
	      }
	 });
}
function checkZwRepeat(){
	var result = {'ok':''};
	var id = "${data.ID}";
	myAjax({url:"zwzj/checkZwRepeat", data:{ZW: $('#ZW').val()}, async: false, success:function(rs){
			if(rs.data == null){
				result = {'ok':'职务可用'};
			}else{
				if(id != rs.data.ID){//修改时判断职务名是否改变
					result = {'error':'职务已存在'};
				}
			}
		}
	});
	return result;
}
</script>
<body style="background: none;">
<form id="validForm" action="zwzj/save" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<table class="formTable">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">职务</td>
			<td width="20%" ><input type="text" name='ZW' id='ZW' class="inputText" data-rule="required;repeat" data-rule-repeat="checkZwRepeat" value="${data.ZW}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">分类</td>
			<td width="20%" ><select name='ZWLB' id='ZWLB' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.zwlb }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.ZWLB }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select>
			<input type="button" name="set" value="设置" class="button" style="margin-left:70px;" onclick="setZwlb();"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">行政职级</td>
			<td width="20%" ><select name='XZZJ' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.xzzj }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.XZZJ }">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
