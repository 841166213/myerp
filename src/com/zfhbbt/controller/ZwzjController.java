package com.zfhbbt.controller;

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
import com.zfhbbt.service.ZwzjService;

@Controller
@RequestMapping("/zwzj")
public class ZwzjController {
	
	@Autowired
	private ZwzjService zwzjService;
	
	@RequestMapping("/manage")
	public String zwzjManage() {
		return "/zfhbbt/zwzj/zwzjManage";
	}
	
	@RequestMapping("/page")
	public void getZwzjPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = zwzjService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/edit")
	public String zwzjEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = zwzjService.getZwzjById(id);
			request.setAttribute("data", data);
		}
		return "/zfhbbt/zwzj/zwzjEdit";
	}
	
	@RequestMapping("/save")
	public void saveZwzj(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		zwzjService.saveZwzj(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		zwzjService.deleteZwzj(ids);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/getZwzjByZw")
	public void getZwzjByZw(HttpServletRequest request, HttpServletResponse response){
		String zw = request.getParameter("ZW");
		Map data = zwzjService.getZwzjByZw(zw);
		Ajax.returnData(data, response);
	}
	
	@RequestMapping("/checkZwRepeat")
	public void checkZwRepeat(HttpServletRequest request, HttpServletResponse response){
		String zw = request.getParameter("ZW");
		Map<String, Object> zwzj = zwzjService.getZwzjByZw(zw);
		Ajax.returnData(zwzj, response);
	}
}
