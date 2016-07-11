package com.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.ReqUtil;
import com.system.service.StandardsService;
import com.system.service.StandardsTypeService;

@Controller
@RequestMapping(value = "/system/standardsType")
public class StandardsTypeController {
	@Autowired
	private StandardsTypeService standardsTypeService;
	@Autowired
	private StandardsService standardsService;
	
	@RequestMapping("/manage")
	public String standardsTypeManage() {
		return "/system/standardsTypeManage";
	}
	
	@RequestMapping("/page")
	public void getStandardsTypePage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = standardsTypeService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/edit")
	public String standardTypeEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = standardsTypeService.getStandardTypeById(id);
			request.setAttribute("data", data);
		}
		return "/system/standardsTypeEdit";
	}
	
	@RequestMapping("/save")
	public void saveStandardType(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		standardsTypeService.saveStandard(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/getById")
	public void getStandardTypeById(String id, HttpServletResponse response){
		Map<String, Object> standardType=standardsTypeService.getStandardTypeById(id);
		Ajax.returnData(standardType, response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		String[] types = request.getParameterValues("types[]");
		standardsTypeService.deleteStandardsType(ids);
		standardsService.deleteStandardsByType(types);
		Ajax.returnData("success", response);
	}
}
