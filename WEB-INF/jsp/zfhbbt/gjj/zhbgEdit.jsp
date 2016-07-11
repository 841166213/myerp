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
			if($("#BGYY").val() == '4'){
				$("#BGYY_QT").prop("disabled",false);
			}else{
				$("#BGYY_QT").prop("disabled",true);
			}
			
			$("#DWID").change(function(){
				$("#JBBM").val($(this).val());
				$("#JBBMMC").val($(this).find("option:selected").text());
				myAjax({ url: "gjj/getZhxx", 
					data: {dwid: $(this).val()},
					success: function(result){
						clear();
						if(result.data != null){
							$("#validForm").setForm(result.data);
						}
						$("[name='SSQX']").val(STD.stqx[$("[name='SSQX']").val()]);
						$("#BGQ_DWXZ1").val(STD.sb_dwxz[$("[name='BGQ_DWXZ']").val()]);
						$("#BGQ_DWXZ2").val(STD.sb_dwxz[$("[name='BGQ_DWXZ']").val()]);
					}
				});
			});
			$("#BGYY").change(function(){
				if($(this).val() == '4'){
					$("#BGYY_QT").prop("disabled",false);
				}else{
					$("#BGYY_QT").prop("disabled",true);
				}
			});
		});
		
		function clear(){
			$("input#readOnly").each(function(){
				$(this).val("");
			});
		}
	</script>
</head>
<style>
	.span{padding-right: 30px;}
</style>
<body style="background: none;">
<div style="margin-bottom: 60px;">
<form id="validForm" action="gjj/zhbgSave" method="post">
	<input type="hidden" name='ID' value="${data.ID}"/>
	<input type="hidden" name="BGQ_DWXZ" id="readOnly" value="${zhxx.BGQ_DWXZ}"/>
	<input type="hidden" name="JBBM" id="JBBM" value="${data.JBBM}"/>
	<table class="formTable">
		<tr>
			<td width="10%" align="right" valign="top" class="font14">申报单位名称</td>
			<td width="20%" ><select name='DWID' id="DWID" data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.jgdw }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.DWID}">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">组织机构代码</td>
			<td width="20%" colspan="3" scope="col"><input type="text" name='ZZJGDM' id="readOnly" class="inputText" size="80" value="${zhxx.ZZJGDM}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">所属区县</td>
			<td width="20%" ><input type="text" name='SSQX' id="readOnly" class="inputText" value="${zhxx.SSQX}" readOnly/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位地址</td>
			<td width="20%" colspan="3" scope="col"><input type="text" name='DWSZDZ' id="readOnly" class="inputText" size="80" value="${zhxx.DWSZDZ}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">邮政编码</td>
			<td width="20%" ><input type="text" name='YZBM' id="readOnly" class="inputText" value="${zhxx.YZBM}" readOnly/></td>
			
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位性质</td>
			<td width="20%" colspan="5" scope="col"><input type="text" name='BGQ_DWXZ1' id="BGQ_DWXZ1" class="inputText" value="${STD_MAP.sb_dwxz[zhxx.BGQ_DWXZ]}" readOnly/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">经办部门</td>
			<td width="20%" ><input type="text" name='JBBMMC' id="JBBMMC" class="inputText" value="${STD_MAP.jgdw[data.JBBM]}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">经办人</td>
			<td width="20%" ><input type="text" name='JBR' data-rule="required" class="inputText" value="${data.JBR}"/></td>
			<td width="10%" align="right" valign="top" class="font14">联系电话</td>
			<td width="20%" ><input type="text" name='JBR_LXDH' data-rule="required" class="inputText" value="${data.JBR_LXDH}"/></td>
		</tr>
		<tr>
			
			<td width="10%" align="right" valign="top" class="font14">变更原因</td>
			<td width="20%" colspan="5" scope="col"><span class="span"><select name='BGYY' id="BGYY" data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.dw_zhbgyy }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.BGYY}">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></span><input type="text" name='BGYY_QT' id="BGYY_QT" data-rule="required" class="inputText" placeholder="其它原因" value="${data.BGYY_QT}" disabled/></td>
		</tr>
		<tr>
			<td colspan="3" scope="col" style="text-align:center;">变更前</td>
			<td colspan="3" scope="col" style="text-align:center;">变更后</td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">单位性质</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='BGQ_DWXZ2' id="BGQ_DWXZ2" class="inputText" value="${STD_MAP.sb_dwxz[zhxx.BGQ_DWXZ]}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">单位性质</td>
			<td width="20%" colspan="2" scope="col"><select name='DWXZ' data-rule="required">
				<option value=""></option>
				<c:forEach var="item" items="${STD_LIST.sb_dwxz }">
				<option value="${item.VALUE }" <c:if test="${item.VALUE == data.DWXZ}">selected</c:if>>${item.TEXT }</option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">账户名称</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='BGQ_ZHMC' id="readOnly" class="inputText" size="40" value="${zhxx.BGQ_ZHMC}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">账户名称</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='ZHMC' data-rule="required" class="inputText" size="40" value="${data.ZHMC}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">开户银行</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='BGQ_KHYH' id="readOnly" class="inputText" size="40" value="${zhxx.BGQ_KHYH}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">开户银行</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='KHYH' data-rule="required" class="inputText" size="40" value="${data.KHYH}"/></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">账号</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='BGQ_YHZH' id="readOnly" class="inputText" size="40" value="${zhxx.BGQ_YHZH}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">账号</td>
			<td width="20%" colspan="2" scope="col"><input type="text" name='YHZH' data-rule="required" class="inputText" size="40" value="${data.YHZH}"/></td>
		</tr>
		<tr>
			<td width="10%" class="textColumn">申请单位补充说明事项</td>
			<td width="20%"  colspan="5"><textarea name='BCSM' rows="2" cols="70" class="inputText">${data.BCSM}</textarea></td>
		</tr>
		<tr>
			<td width="10%" align="right" valign="top" class="font14">管理中心经办人</td>
			<td width="20%" ><input type="text" name='GLZXJBR' class="inputText" value="${erp_session_user.account}" readOnly/></td>
			<td width="10%" align="right" valign="top" class="font14">联系电话</td>
			<td width="20%" ><input type="text" name='GLZXJBR_LXDH' data-rule="required" class="inputText" value="${data.GLZXJBR_LXDH}"/></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doCommonSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</div>
</body>
</html>
