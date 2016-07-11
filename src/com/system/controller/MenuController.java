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
import com.system.service.MenuService;

/**
 * @author 闄堝妗�
 *
 */
@Controller
@RequestMapping(value = "/system/menu")
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@RequestMapping("/manage")
	public String menuManage() {
		return "/system/menuManage";
	}	
	@RequestMapping("/menuTreeManage")
	public String menuTreeManage() {
		return "/system/menuTreeManage";
	}	
	@RequestMapping("/firstLevel")
	public String firstLevelView() {
		return "/system/firstLevelMenu";
	}
	@RequestMapping("/secondLevel")
	public String secondLevelView(HttpServletRequest request) {
		List<Menu> list = menuService.getFirstLevelMenu();
		request.setAttribute("list", list);
		return "/system/secondLevelMenu";
	}
	@RequestMapping("/secondLevel/add")
	public String addSecondLevelView(HttpServletRequest request) {
		List<Menu> list = menuService.getFirstLevelMenu();
		request.setAttribute("list", list);
		return "/system/secondLevelMenuAdd";
	}
	@RequestMapping("/firstLevel/page")
	public void getFirstLevelPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = menuService.queryFirstLevelPage(
				query, currentPage, pageSize);
		AjaxUtil.ajaxPrintJsonObject(page, response);
	}
	@RequestMapping("/secondLevel/page")
	public void getSecondLevelPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = menuService.querySecondLevelPage(
				query, currentPage, pageSize);
		AjaxUtil.ajaxPrintJsonObject(page, response);
	}
	@RequestMapping("/getFirstLevleMenu")
	public void getFirstLevleMenu(HttpServletRequest request, HttpServletResponse response) {
		List<Menu> list = menuService.getFirstLevelMenu();
		AjaxUtil.ajaxPrintJsonArray(list, response);
	}
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		menuService.delete(ids);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		menuService.save(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/page")
	public void getMenuPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = menuService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/edit")
	public String menuEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String level = request.getParameter("level");
		if(id != null){
			Map<String, Object> data = menuService.getMenuById(id);
			request.setAttribute("data", data);			
		}
		if("2".equals(level)){
			List<Map<String, Object>> menuList=menuService.getLevelMenu("1");
			request.setAttribute("menuList", menuList);	
		}
		if("3".equals(level)){
			List<Map<String, Object>> menuList=menuService.getLevelMenu("2");
			request.setAttribute("menuList", menuList);	
		}
		return "/system/menuEdit";
	}
	@RequestMapping("/cancelMenu")
	public void cancelMenu(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		menuService.cancelMenu(id);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/useMenu")
	public void useMenu(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		menuService.useMenu(id);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/getAllMenu")
	public void getAllMenu(HttpServletRequest request, HttpServletResponse response){
		List<Map<String, Object>> menuList=menuService.getAllMenu();
		Ajax.returnData(menuList, response);
	}
}
