package com.zfhbbt.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.DateUtil;
import com.common.util.ReqUtil;
import com.zfhbbt.service.GjjService;
import com.zfhbbt.service.JgdwService;
import com.zfhbbt.service.SbService;

@Controller
@RequestMapping("/gjj")
public class GjjController {
	
	@Autowired
	private GjjService gjjService;

	@Autowired
	private SbService sbService;

	@Autowired
	private JgdwService jgdwService;

	
	//-----------账户变更---------------------
	@RequestMapping("/zhbgManage")
	public String zhbgManage() {
		return "/zfhbbt/gjj/zhbgManage";
	}
	
	@RequestMapping("/zhbgPage")
	public void getZhbgPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = gjjService.queryZhbgPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/zhbgEdit")
	public String zhbgEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			Map data = gjjService.getZhbgById(id);
			request.setAttribute("data", data);
			Map<String, Object> zhxx = gjjService.getZhxxByDwid(data.get("DWID").toString());
			request.setAttribute("zhxx", zhxx);
		}
		return "/zfhbbt/gjj/zhbgEdit";
	}
	
	@RequestMapping("/zhbgSave")
	public void saveZhbg(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		gjjService.saveZhbg(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zhbgView")
	public String zhbgView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = gjjService.getZhbgById(id);
		DateUtil.fmtDate(data);
		request.setAttribute("data", data);
		return "/zfhbbt/gjj/zhbgView";
	}
	
	@RequestMapping("/zhbgPrint")
	public String zhbgPrint(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = gjjService.getZhbgById(id);
		DateUtil.fmtDate(data);
		String tjsj=data.get("SBSJ").toString();
		String[] nyr=tjsj.split("-");
		data.put("YEAR", nyr[0]);
		data.put("MONTH", nyr[1]);
		data.put("DAY", nyr[2]);
		request.setAttribute("data", data);
		return "/zfhbbt/gjj/zhbgPrint";
	}
	
	@RequestMapping("/zhbgCancel")
	public void zhbgCancel(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		gjjService.zhbgCancel(id);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zhbgConfirm")
	public void zhbgConfirm(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("ID");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("ID", id);
		data.put("ZT", "1");
		gjjService.saveZhbg(data);
		Map<String, Object> zhbg = gjjService.getZhbgById(id);
		zhbg.put("ID", zhbg.get("DWID"));
		jgdwService.saveJgdw(zhbg);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/getZhxx")
	public void getZhbgxx(HttpServletRequest request, HttpServletResponse response) {
		String dwid = request.getParameter("dwid");
		Map<String, Object> data = gjjService.getZhxxByDwid(dwid);
		Ajax.returnData(data, response);
	}

	
	@RequestMapping("/dwhcPage")
	public void dwhcPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = gjjService.queryDwhcPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/dwhcManage")
	public String dwhcManage(HttpServletRequest request) {
		return "/zfhbbt/gjj/dwhcManage";
	}
	@RequestMapping("/dwdjEdit")
	public String dwdjEdit(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = gjjService.getDwdjById(id);
		if(data == null){//新增时，获取单位信息作为默认值
			data = gjjService.getDwxxByDwsbId(id);
			Map sbxx = sbService.getDwsbById(id);
			data.put("HCZRS", sbxx.get("BND_HJ_RS"));
			data.put("HCZJE", sbxx.get("BKJE"));
			data.put("DWSBID", id);
			data.put("method", "add");
		}else{
			data.put("method", "update");
		}
		DateUtil.fmtDate(data);
		request.setAttribute("data", data);
		return "/zfhbbt/gjj/dwdjEdit";
	}
	
	@RequestMapping("/saveDwdj")
	public void saveDwdj(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		gjjService.saveDwdj(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwdjSubmit")
	public void dwdjSubmit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		gjjService.dwdjSubmit(id);
		Ajax.returnSuccess(response);
	}

	//-----------账户变更---------------------
	
	//-----------职工提取---------------------
	@RequestMapping("/zgtqManage")
	public String zgtqManage() {
		return "/zfhbbt/gjj/zgtqManage";
	}
	
	@RequestMapping("/zgtqPage")
	public void getZgtqPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = gjjService.queryZgtqPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/zgtqEdit")
	public String zgtq(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			Map data = gjjService.getZgtqById(id);
			request.setAttribute("data", data);
		}
		return "/zfhbbt/gjj/zgtqEdit";
	}
	
	@RequestMapping("/zgtqSave")
	public void saveZgtq(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		gjjService.saveZgtq(data);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zgtqView")
	public String zgtqView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = gjjService.getZgtqById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/gjj/zgtqView";
	}
	
	@RequestMapping("/zgtqCancel")
	public void zgtqCancel(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		gjjService.zgtqCancel(id);
		Ajax.returnSuccess(response);
	}
	
	@RequestMapping("/zgtqConfirm")
	public void zgtqConfirm(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("ID");
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("ID", id);
		data.put("ZT", "1");
		gjjService.saveZgtq(data);
		Ajax.returnSuccess(response);
	}
	//-----------提取转移---------------------
}
