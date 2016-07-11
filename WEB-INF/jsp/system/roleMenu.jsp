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
    <title>角色菜单</title>
	<script type="text/javascript" src="js/jqgrid/js/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.form.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="js/page.js"></script>
</head>
<script language="javascript">
function doSubmit(){
	$('#dataForm').ajaxSubmit({
	        dataType: 'text',
	        success: function(d){
	        	showSuccessMsg("保存成功");
	        	parentCancelReload();
	        }
	    });
};
</script>  
<body class="ContentBody">
<form id="dataForm" action="system/role/saveRoleMenu" method="post">
<input type="hidden" name="roleId" value="${roleId}"/>
<div class="MainDiv">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  <tr>
      <th class="tablestyle_title" >角色菜单</th>
  </tr>
  <tr>
    <td class="CPanel">
	<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
		<tr align="center">
			<td class="TablePanel"><br/></td>
		</tr>
		<tr>
			<td width="100%">
				<fieldset style="height:100%;">
				<legend style="font-weight: normal;"><font size="3"><strong>菜单</strong></font></legend>
					 <ul>
					 <c:forEach var="item" items="${list}">
					 	<li>${item.menuName}</li>
					 	<ul type="circle">
					 	<c:forEach var="menu" items="${item.children}">
					 	  <li><input name="menus" type="checkbox" value="${menu.id}" <c:if test="${menu.checked}">checked</c:if>/>${menu.menuName}</li>
					 	</c:forEach>
					 	</ul> 
					 </c:forEach>
					 </ul> 
		       </fieldset>
	     </td>
          </tr>
		<tr>
			<td align="center" height="50px">
			<input type="button"  value="保存" onclick="doSubmit()"/>　			
			<input type="button" name="Submit2" value="关闭" class="button" onclick="doCancel();"/></td>
		</tr>
		</table>
		</td></tr></table></div>
</form>
</body>
</html>
