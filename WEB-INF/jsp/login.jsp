<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	 <base href="<%=basePath%>">
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>金谷erp</title>
	<link type="text/css" rel="stylesheet" href="js/validator-0.7.3/jquery.validator.css"/>
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/jquery.validator.js"></script>
	<script type="text/javascript" src="js/validator-0.7.3/local/zh_CN.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
  	<script>
		$(function(){
			$(document).keypress(function(event){
				if(event.which == 13){
					doLogin();
				}
			});
		})
		function doLogin(){
			$("#loginForm").isValid(function(isValid){if(isValid){
				$("#loginForm").ajaxSubmit({
					dataType:"json",
					success:function(result){
						if(result.data=="CheckCodeError"){
							layer.msg("验证码错误，请重新输入!");
							document.getElementById('randomCode').value="";
							$("#loginForm").validator("hideMsg","#randomCode");
							refresh();
						}else if(result.data=="AccountOrPsError"){
							layer.msg("用户名或密码错误，请重新输入!");
							document.getElementById('password').value="";
							$("#loginForm").validator("hideMsg","#password");
							document.getElementById('randomCode').value="";
							$("#loginForm").validator("hideMsg","#randomCode");
							refresh();
						}else if(result.data=="success"){
							window.location = "<%=basePath%>index";
						}
					}
				});
			}});
		}
		function refresh(){
			document.getElementById('randomCodeImg').src="<%=basePath%>checkCode"+"?"+Math.random();
		}
	</script>
</head>
<body>
	<form action="login/doLogin" method="post" id="loginForm">
	    <table>
	    	<tr>
			    <td>用户名</td>
			    <td><input type="text" name="ACCOUNT" data-rule="required"></td>
		    </tr>
		    <tr>
			    <td>密码</td>
			    <td><input type="password" name="PASSWORD" id="password" data-rule="required"></td>
		    </tr>
		    <!-- 
			<tr>
				<td>验证码</td>
			    <td><input type="text" type="text" id="randomCode" name="randomCode" data-rule="required"></td>
			</tr>
			 -->
	    </table>
	</form>
	<!-- 
	<img id="randomCodeImg" title="点击更换" onclick="refresh()" src="<%=basePath%>checkCode"><br>
	 -->
	<input type="button" onclick="doLogin()" value="登 录">
</body>
</html>