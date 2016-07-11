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
import com.zfhbbt.service.BwbService;
import com.zfhbbt.service.SbService;

@Controller
@RequestMapping("/bwb")
public class BwbController {
	@Autowired
	private BwbService bwbService;
	@Autowired
	private SbService sbService;
	
	@RequestMapping("/bwbVerifyManage")
	public String bwbVerifyManage() {
		return "/zfhbbt/bwb/bwbVerifyManage";
	}
	@RequestMapping("/bwbVerify")
	public String bwbVerify(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = sbService.getDwsbqkById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/bwb/bwbVerify";
	}
	
	@RequestMapping("/bwbVerifyPage")
	public void bwbVerifyPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		query.put("ZT", "1");
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwsbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/bwbPass")
	public void bwbPass(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		bwbService.bwbPass(data);
		Ajax.returnSuccess(response);
	}
}
