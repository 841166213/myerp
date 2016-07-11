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
import com.zfhbbt.service.BwbService;
import com.zfhbbt.service.CzjService;
import com.zfhbbt.service.SbService;

@Controller
@RequestMapping("/czj")
public class CzjController {
	@Autowired
	private CzjService czjService;
	@Autowired
	private SbService sbService;
	
	@RequestMapping("/czjVerifyManage")
	public String czjVerifyManage() {
		return "/zfhbbt/czj/czjVerifyManage";
	}
	@RequestMapping("/czjVerify")
	public String czjVerify(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = sbService.getDwsbqkById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/czj/czjVerify";
	}
	
	@RequestMapping("/czjVerifyPage")
	public void czjVerifyPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		query.put("SHZT_FGB", "1");
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwsbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/czjPass")
	public void czjPass(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		czjService.czjPass(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zjhbManage")
	public String zjhbManage() {
		return "/zfhbbt/czj/zjhbManage";
	}
	@RequestMapping("/zjhbpcAdd")
	public String zjhbpcAdd(HttpServletRequest request) {
		return "/zfhbbt/czj/zjhbpcAdd";
	}
	@RequestMapping("/getZjhbListByIds")
	public void getZjhbListByIds(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		List<Map> list = czjService.getZjhbListByIds(data);
		Ajax.returnData(list, response);
	}
	@RequestMapping("/addZjbkpc")
	public void addZjbkpc(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		czjService.addZjbkpc(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zjhbpcManage")
	public String zjhbpcManage() {
		return "/zfhbbt/czj/zjhbpcManage";
	}
	@RequestMapping("/zjhbpcEdit")
	public String zjhbpcEdit(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = czjService.getZjhbpcById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/czj/zjhbpcEdit";
	}
	@RequestMapping("/zjhbpcView")
	public String zjhbpcView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = czjService.getZjhbpcById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/czj/zjhbpcView";
	}
	@RequestMapping("/zjhbpcSelectMx")
	public String zjhbpcSelectMx(HttpServletRequest request) {
		return "/zfhbbt/czj/zjhbpcSelectMx";
	}
	@RequestMapping("/zjhbpcPage")
	public void zjhbpcPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = czjService.queryZjhbpcPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/getZjhbpcmxList")
	public void getZjhbpcmxList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		List<Map> list = czjService.getZjhbpcmxList(data);
		Ajax.returnData(list, response);
	}
	@RequestMapping("/czjPcmxPage")
	public void czjPcmxPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		query.put("SHZT_CZJ", "1");
		query.put("ZJHBPC_NUll", "1");
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwsbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/addZjhbpcmx")
	public void addZjhbpcmx(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		czjService.addZjhbpcmx(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/saveZjhbpc")
	public void saveZjhbpc(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		czjService.updateZjhbpc(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/cancelZjhbpcMx")
	public void cancelZjhbpcMx(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		czjService.cancelZjhbpcMx(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/zjhbpcCancel")
	public void zjhbpcCancel(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		czjService.zjhbpcCancel(id);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/zjhbpcConfirm")
	public void zjhbpcConfirm(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		data.put("HBZT", "1");
		czjService.updateZjhbpc(data);
		Ajax.returnSuccess(response);
	}
}
