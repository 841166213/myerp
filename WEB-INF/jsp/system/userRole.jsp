<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
  <head>
    <title>用户角色管理</title>

 <link rel="stylesheet" rev="stylesheet" href="css/style.css" type="text/css" media="all" />
</head>
<script language="javascript">
function doBack(){
	window.location = "userAction.do?Status=manage";
};
</script>  
<body class="ContentBody">
<form action="userAction.do?Status=saveUserRole" method="post">
<input type="hidden" name="userId" value="${userId}"/>
<div class="MainDiv">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  <tr>
      <th class="tablestyle_title" >用户角色管理</th>
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
				<legend style="font-weight: normal;"><font size="3"><strong>角色</strong></font></legend>
					<table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					   <colgroup width="20%"></colgroup>
					   <colgroup width="20%"></colgroup>
					   <colgroup width="20%"></colgroup>
					   <colgroup width="20%"></colgroup>
					 <% 
					 	List list = (List)request.getAttribute("list");
					 	
					 	for(int i=0; i<list.size(); i=i+4) {
					 %>
					 <tr>
					 <%
					 		for(int j=0; j<4 && i+j<list.size(); j++){
					 			RoleForm role = (RoleForm)list.get(i+j);
					 			
					 %>
					    <td><input name="roles" type="checkbox" value="<%= role.getId() %>" <% if(role.isChecked()) {%>checked<% } %>/>
					    <%= role.getRoleName() %>
					    </td>
					 	<%	}  %>
					  </tr>
					  <%} %>
		       		  </table>
		       </fieldset>
	     </td>
          </tr>
		<tr>
			<td align="center" height="50px">
			<input type="submit" name="Submit" value="保存" class="button"/>　			
			<input type="button" name="Submit2" value="关闭" class="button" onclick="doBack();"/></td>
		</tr>
		</table>
		</td></tr></table></div>
</form>
</body>
</html>
