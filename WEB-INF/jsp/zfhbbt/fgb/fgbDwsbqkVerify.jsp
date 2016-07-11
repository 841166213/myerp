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
	parent.layer.confirm("是否审核通过？",function(index){
		myAjax({ url: "fgb/fgbDwsbqkPass", 
			data: {DWSBID: ID},
			success: function(result){
				showSuccessMsg("审核成功");
				parentCancelReload();
			}
		});
		parent.layer.close(index);
	});
}
</script>
<body style="background: none;">
<div style="margin-bottom: 60px;">
	<jsp:include page="/WEB-INF/jsp/zfhbbt/sb/dwsbqkbView.jsp"></jsp:include>
</div>
<div class="bottomButton">
	<input type="button" name="Submit" value="审核通过" class="button redButton" onclick="doVerify(${data.DWSBID });"/>	
    <input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/>
</div>
</body>
</html>
