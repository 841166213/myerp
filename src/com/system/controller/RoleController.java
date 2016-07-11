/**
 * 
 */
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
import com.system.model.Menu;
import com.system.service.RoleService;

/**
 * @author 陈家桂
 *
 */
@Controller
@RequestMapping(value = "/system/role")
public class RoleController {
	@Autowired
	private RoleService roleService;
	
	@RequestMapping("/manage")
	public String roleManage() {
		return "/system/roleManage";
	}
	@RequestMapping("/edit")
	public String roleEdit(HttpServletRequest request) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = roleService.getRoleById(id);
			request.setAttribute("data", data);
		}
		return "/system/roleEdit";
	}
	
	
	@RequestMapping(value = "/roleMenu")
	public String roleMenu(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = roleService.getRoleById(id);
		request.setAttribute("role", data);
		return "/system/roleMenuSet";
	}
	
	@RequestMapping("/getRoleMenuEditTree")
	public void getRoleMenuTree(HttpServletRequest request, HttpServletResponse response) {
		String roleId = request.getParameter("roleId");
		List<Map<String, Object>> data = roleService.getRoleMenuEditTree(roleId);
		Ajax.returnData(data, response);
	}
	
	@RequestMapping("/page")
	public void getRolePage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = roleService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		roleService.deleteRoles(ids);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		roleService.save(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/updateRoleMenu")
	public void updateRoleMenu(HttpServletRequest request, HttpServletResponse response) {
		String roleId = request.getParameter("roleId");
		String[] menuIds = request.getParameterValues("menuIds[]");
		roleService.saveRoleMenu(roleId, menuIds);
		Ajax.returnSuccess(response);
	}

}
