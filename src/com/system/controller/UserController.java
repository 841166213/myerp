package com.system.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.AjaxUtil;
import com.common.util.ReqUtil;
import com.common.util.SessionUtil;
import com.system.service.RoleService;
import com.system.service.UserService;

@Controller
@RequestMapping(value = "/system/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	
	@RequestMapping("/manage")
	public String roleManage(HttpServletRequest req) {
		List<Map> roleList = roleService.getRoles();
		req.setAttribute("roleList", roleList);
		return "/system/userManage";
	}
	@RequestMapping("/page")
	public void queryUserPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = userService.queryUserPage(
				query, currentPage, pageSize);
		
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/edit")
	public String editUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = userService.getUser(id);
			request.setAttribute("data", data);
		}
		return "/system/userEdit";
	}
	@RequestMapping("/checkAccountRepeat")
	public void checkAccountRepeat(HttpServletRequest request, HttpServletResponse response) {
		String account = request.getParameter("ACCOUNT");
		Map<String, Object> user = userService.getUserByAccount(account);
		if(user == null){
			Ajax.printJsonString("{'ok':'璇ュ笎鍙峰彲鐢�'}", response);;
		}else{
			Ajax.printJsonString("{'error':'璇ュ笎鍙峰凡娉ㄥ唽'}", response);;
		}
	}
	@RequestMapping("/save")
	public void saveUser(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		if(data.get("oldPs") != null){//修改密码
			if(data.get("oldPs").toString().equals(SessionUtil.getUserSession(request).getPassword())){
				userService.saveUser(data);
				SessionUtil.removeUserSession(request);
				Ajax.returnSuccess(response);
			}else{
				Ajax.returnFail(response);
			}
		}else{//新增修改用户信息
			userService.saveUser(data);
			Ajax.returnSuccess(response);
		}
	}
	@RequestMapping("/batchDelete")
	public void deleteUsers(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		userService.deleteUsers(ids);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/editUserRole")
	public String editUserRole(HttpServletRequest request) {
		String id = request.getParameter("id");
		List<Map> userRoles = userService.getUserRoles(id);
		request.setAttribute("userRoles", userRoles);
		request.setAttribute("userId", id);
		return "/system/userRoleEdit";
	}
	@RequestMapping("/saveUserRole")
	public void saveUserRole(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("userId");
		String[] roleIds = request.getParameterValues("roleId");
		userService.saveUserRole(userId, roleIds);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/resetPs")
	public String resetPassword(HttpServletRequest request, HttpServletResponse response){
		return "/system/resetPassword";		
	}
	
}
