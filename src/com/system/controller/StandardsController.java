package com.system.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.listener.InitListener;
import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.ReqUtil;
import com.system.service.StandardsService;

@Controller
@RequestMapping(value = "/system/standards")
public class StandardsController {
	@Autowired
	private StandardsService standardsService;
	
	@RequestMapping("/manage")
	public String standardsManage(HttpServletRequest request) {
		return "/system/standardsManage";
	}
	
	@RequestMapping("/page")
	public void getStandardsPage(HttpServletRequest request, HttpServletResponse response, String type) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = standardsService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/edit")
	public String standardEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = standardsService.getStandardById(id);
			request.setAttribute("data", data);
		}
		return "/system/standardsEdit";
	}
	
	@RequestMapping("/save")
	public void saveStandard(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		standardsService.saveStandard(data);
		String type = (String) data.get("TYPE");
		refreshInitStdByType(type, request);
		Ajax.returnSuccess(response);
	}
	//刷新代码缓存
	private void refreshInitStdByType(String type, HttpServletRequest request) {
		Map<String, List<Map>> stdList = (Map<String, List<Map>>) request.getSession().getServletContext().getAttribute(InitListener.STD_LIST);
		Map<String, Map> stdMap = (Map<String, Map>) request.getSession().getServletContext().getAttribute(InitListener.STD_MAP);
		List<Map> dmList = standardsService.getStdListByType(type);
		stdList.put(type, dmList);
		stdMap.put(type, standardsService.listToMap(dmList));
	}

	@RequestMapping("/cancelStandard")
	public void cancelStandard(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		standardsService.cancelStandard(id);
		
		String type = request.getParameter("type");
		refreshInitStdByType(type, request);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/useStandard")
	public void useStandard(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		standardsService.useStandard(id);
		
		String type = request.getParameter("type");
		refreshInitStdByType(type, request);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		standardsService.deleteStandards(ids);
		
		String type = request.getParameter("type");
		refreshInitStdByType(type, request);
		Ajax.returnData("success", response);
	}
}
