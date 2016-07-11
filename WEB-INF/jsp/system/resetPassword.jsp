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
		function doSubmit(){			
			$("#resetPsForm").isValid(function(isValid){if(isValid){
				$("#resetPsForm").ajaxSubmit({
					dataType:"json",
					success:function(result){
						if(result.status=="success"){
							parent.layer.alert("密码修改成功，请重新登录！",function(){
								getIndexWindow().location = "<%=basePath%>login";
							});
						}else{
							layer.msg('您输入的原密码错误');
							document.getElementById('oldPs').value="";
							$("#resetPsForm").validator("hideMsg","#oldPs");
						}
					},
					error: function(){
					     layer.msg('请求失败');
				    }
				});
			}});
		}
	</script>
</head>
<body style="background: none;">
<form id="resetPsForm" action="system/user/save" method="post">
	<input type="hidden" name='ID' value="${erp_session_user.id}"/>
	<table class="formTable">
		<tr>
			<td width="70" align="right" valign="top" class="font14">原密码</td>
			<td valign="top"><input type="password" name='oldPs' id='oldPs' data-rule="required" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">新密码</td>
			<td valign="top"><input type="password" name='PASSWORD' data-rule="required" class="inputText"/></td>
		</tr>
		<tr>
			<td width="70" align="right" valign="top" class="font14">确认密码</td>
			<td valign="top"><input type="password" name='newPsAgain' data-rule="required;match[PASSWORD]" data-msg-match="新密码与确认密码不一致 " class="inputText"/></td>
		</tr>
	</table>
</form>
<div class="bottomButton">
	<input type="button" name="Submit" value="保存" class="button redButton" onclick="doSubmit();"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
<!-- bottomButton -->
</body>
</html>
