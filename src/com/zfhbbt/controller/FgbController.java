package com.zfhbbt.controller;

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
import com.common.util.ReqUtil;
import com.zfhbbt.service.FgbService;
import com.zfhbbt.service.SbService;

@Controller
@RequestMapping("/fgb")
public class FgbController {
	@Autowired
	private SbService sbService;
	@Autowired
	private FgbService fgbService;
	
	@RequestMapping("/fgbVerifyManage")
	public String fgbVerifyManage() {
		return "/zfhbbt/fgb/fgbVerifyManage";
	}
	@RequestMapping("/fgbVerifyPage")
	public void fgbVerifyPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = fgbService.queryFgbVerifyPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	
	@RequestMapping("/dwryxxVerify")
	public String dwryxxVerify() {
		return "/zfhbbt/fgb/dwryxxVerify";
	}
	@RequestMapping("/dwryxxVerifyPage")
	public void dwryxxVerifyPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryRysbxxPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/verifyRyxx")
	public void verifyRyxx(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		sbService.batchVerifyRyxx(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/fgbDwsbqkVerify")
	public String fgbDwsbqkVerify(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = sbService.getDwsbqkById(id);
		request.setAttribute("data", data);	
		return "/zfhbbt/fgb/fgbDwsbqkVerify";
	}
	
	@RequestMapping("/fgbDwsbqkPass")
	public void fgbDwsbqkPass(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		fgbService.fgbDwsbqkPass(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwqesbVerify")
	public String dwqesbVerify() {
		return "/zfhbbt/fgb/dwqesbVerify";
	}
	@RequestMapping("/dwcesbVerify")
	public String dwcesbVerify() {
		return "/zfhbbt/fgb/dwcesbVerify";
	}
	@RequestMapping("/verifySbxx")
	public void verifySbxx(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		sbService.batchVerifySbxx(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/submitVerify")
	public void submitVerify(HttpServletRequest request, HttpServletResponse response){
		String id=request.getParameter("id");
		fgbService.submitVerify(id);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/sbxxCheck")
	public String sbxxCheck() {
		return "/zfhbbt/fgb/sbxxCheck";
	}
	@RequestMapping("/sbxxCheckList")
	public void sbxxCheckList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		List<Map> list = fgbService.getRysbxxHistoryCheckList(data);
		Ajax.returnData(list, response);
	}
}
