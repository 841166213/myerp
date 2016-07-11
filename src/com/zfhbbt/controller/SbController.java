package com.zfhbbt.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.DateUtil;
import com.common.util.ExcelUtil;
import com.common.util.ReqUtil;
import com.common.util.SessionUtil;
import com.common.util.StringUtil;
import com.system.model.SessionUser;
import com.zfhbbt.service.SbService;

import jxl.Cell;
import jxl.JXLException;
import jxl.Sheet;
import jxl.Workbook;

//申报
@Controller
@RequestMapping("/sb")
public class SbController {
	@Autowired
	private SbService sbService;
	
	//----------单位申报信息-------------
	@RequestMapping("/dwsbManage")
	public String dwsbManage(HttpServletRequest request) {
		request.setAttribute("years", DateUtil.getYearSelect());
		return "/zfhbbt/sb/dwsbManage";
	}
	@RequestMapping("/dwsbQuery")
	public String dwsbQuery(HttpServletRequest request) {
		return "/zfhbbt/sb/dwsbQuery";
	}
	@RequestMapping("/dwsbPage")
	public void dwsbPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwsbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/addDwsb")
	public void addDwsb(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		sbService.addDwsb(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/deleteDwsb")
	public void deleteDwsb(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		Map data = sbService.getDwsbById(id);
		if(!"1".equals(data.get("ZT"))){
			sbService.deleteDwsb(id);
		}
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/doSubmit")
	public void doSubmit(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		data.put("ZT", 1);
		sbService.doSubmit(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwsbHistory")
	public String dwsbHistory(HttpServletRequest request){
		return "/zfhbbt/sb/dwsbHistory";
	}
	@RequestMapping("/dwsbHistoryPage")
	public void dwsbHistoryPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwsbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	//----------单位申报信息-------------
	
	//----------人员申报信息-------------
	//----------全额申报
	@RequestMapping("/dwqesbManage")
	public String dwqesbManage(HttpServletRequest request) {
		String id=request.getParameter("id");
		Map<String, Object> data=sbService.getDwsbqkById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwqesbManage";
	}
	@RequestMapping("/dwqesbPage")
	public void dwqesbPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwqesbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/downloadDwqesbImportModel")
	public String downloadDwqesbImportModel(HttpServletRequest request, HttpServletResponse response) {
		return "forward:/comm/downloadImportModel?fileName=单位全额申报导入模板.xls";
	}
	@RequestMapping("/importDwqesb")
	public void importDwqesb(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws JXLException, IOException {
		String fileName = file.getOriginalFilename();
		String[] heads = {"在职状态", "姓名", "身份证号码", "参加工作时间", "进入机关事业单位工作时间",
				"职务（职称）", "居住情况", "现居住房屋地址", "开始领取时间", "已领取年数",
				"上年度月发放标准", "本年度月发放标准", "本年度领取方式", "本年度发放额合计", "配偶姓名", "配偶身份证号码"};
		String[] keys = {"ZZZT", "XM", "SFZHM", "CJGZSJ", "JRJGSYDWGZSJ", 
				"ZW", "JZQK", "XJZFWDZ", "KSLQSJ", "YLQNS", 
				"SNDYFFBZ", "BNDYFFBZ", "LQFS", "FFEHJ", "POXM", "POSFZHM"};
		
		Workbook book = Workbook.getWorkbook(file.getInputStream());	 
		Sheet sheet = book.getSheet(0);
		//验证表头
		Cell[] cells= sheet.getRow(0);
		for(int i=0; i< heads.length; i++){
			if(!heads[i].equals(ExcelUtil.getCellContent(cells, i))){
				Ajax.returnFail("导入模板不正确", response);
				return;
			}
		}
		//读取数据
		List<Map> list = new ArrayList<Map>();
		Map data;
		String sbdwxxid = request.getParameter("DWSBID");
		int rowCount = sheet.getRows();	//获取总行数
		for (int i = 1; i < rowCount; i++) {
			data = ReqUtil.getParameterMap(request);
			data.put("SBLX", "1");
			cells = sheet.getRow(i);
			Map<String, Map> stdMap = (Map<String, Map>)request.getSession().getServletContext().getAttribute("STD_MAP_turn");
			for(int j=0; j<keys.length; j++){
				String cellContent = ExcelUtil.getCellContent(cells,j);
				if(j == 6){
					data.put(keys[j], stdMap.get("sb_jzqk").get(cellContent));
				}else if(j == 5){
					data.put(keys[j], stdMap.get("zw").get(cellContent));
				}else if(j == 0){
					data.put(keys[j], stdMap.get("sb_zzzt").get(cellContent));
				}else if(j == 12){
					data.put(keys[j], stdMap.get("sb_lqfs").get(cellContent));
				}else{
					data.put(keys[j], cellContent);
				}				
			}
			SessionUser suser = SessionUtil.getUserSession(request);
		    if(suser != null){
		    	data.put("suserId", suser.getId());
		    }
			list.add(data);
		}
		sbService.batchInsertRysbxx(list, sbdwxxid);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwqesbView")
	public String dwqesbView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> sbqk=sbService.getDwsbqkById(id);
		
		Map data = sbService.getRysbxx(id);
		DateUtil.fmtDate(data);
		request.setAttribute("sbqk", sbqk);
		
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwqesbView";
	}
	@RequestMapping("/dwqesbPrint")
	public String dwqesbPrint(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map param = new HashMap();
		param.put("dwsbid", id);
		param.put("sblx", 1);
		Map<String, Object> dwsb=sbService.getDwsbById(id);
		DateUtil.fmtDate(dwsb);
		String tjsj=dwsb.get("TJSJ").toString();
		String[] nyr=tjsj.split("-");
		dwsb.put("YEAR", nyr[0]);
		dwsb.put("MONTH", nyr[1]);
		dwsb.put("DAY", nyr[2]);
		List<Map<String, Object>> data=sbService.getRysbxxList(param);
		DateUtil.fmtDate(data);
		request.setAttribute("dwsb", dwsb);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwqesbPrint";
	}
	//----------全额申报
	//----------差额申报
	@RequestMapping("/dwcesbManage")
	public String dwcesbManage(HttpServletRequest request) {
		String id=request.getParameter("id");
		Map<String, Object> data=sbService.getDwsbqkById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwcesbManage";
	}
	@RequestMapping("/dwcesbPage")
	public void dwcesbPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryDwcesbPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/downloadDwcesbImportModel")
	public String downloadDwcesbImportModel(HttpServletRequest request, HttpServletResponse response) {
		return "forward:/comm/downloadImportModel?fileName=单位差额申报导入模板.xls";
	}
	@RequestMapping("/importDwcesb")
	public void importDwcesb(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws JXLException, IOException {
		String fileName = file.getOriginalFilename();
		String[] heads = {"在职状态", "姓名", "身份证号码", "职务（职称）", "居住情况", 
				"房改面积", "差额货币补贴总额", "房屋所在地址", "开始领取时间", "已领取年数", 
				"上年度月发放标准", "本年度月发放标准", "本年度领取方式", "本年度发放额合计", "配偶姓名", "配偶身份证号码"};
		String[] keys = {"ZZZT", "XM", "SFZHM", "ZW", "JZQK",
				"FGMJ", "CEHBBTZE", "FWSZDZ", "KSLQSJ", "YLQNS", 
				"SNDYFFBZ", "BNDYFFBZ", "LQFS", "FFEHJ", "POXM", "POSFZHM"};
		
		Workbook book = Workbook.getWorkbook(file.getInputStream());	 
		Sheet sheet = book.getSheet(0);
		//验证表头
		Cell[] cells= sheet.getRow(0);
		for(int i=0; i< heads.length; i++){
			if(!heads[i].equals(ExcelUtil.getCellContent(cells, i))){
				Ajax.returnFail("导入模板不正确", response);
				return;
			}
		}
		//读取数据
		List<Map> list = new ArrayList<Map>();
		Map data;
		String sbdwxxid = request.getParameter("DWSBID");
		int rowCount = sheet.getRows();	//获取总行数
		for (int i = 1; i < rowCount; i++) {
			data = ReqUtil.getParameterMap(request);
			data.put("SBLX", "2");
			cells = sheet.getRow(i);
			Map<String, Map> stdMap = (Map<String, Map>)request.getSession().getServletContext().getAttribute("STD_MAP_turn");
			for(int j=0; j<keys.length; j++){
				String cellContent = ExcelUtil.getCellContent(cells,j);
				if(j == 4){
					data.put(keys[j], stdMap.get("sb_jzqk").get(cellContent));
				}else if(j == 3){
					data.put(keys[j], stdMap.get("zw").get(cellContent));
				}else if(j == 0){
					data.put(keys[j], stdMap.get("sb_zzzt").get(cellContent));
				}else if(j == 12){
					data.put(keys[j], stdMap.get("sb_lqfs").get(cellContent));
				}else{
					data.put(keys[j], cellContent);
				}				
			}
			SessionUser suser = SessionUtil.getUserSession(request);
		    if(suser != null){
		    	data.put("suserId", suser.getId());
		    }
			list.add(data);
		}
		sbService.batchInsertRysbxx(list, sbdwxxid);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwcesbView")
	public String dwcesbView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> sbqk=sbService.getDwsbqkById(id);
		
		Map data = sbService.getRysbxx(id);
		DateUtil.fmtDate(data);
		
		request.setAttribute("sbqk", sbqk);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwcesbView";
	}
	@RequestMapping("/dwcesbPrint")
	public String dwcesbPrint(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map param = new HashMap();
		param.put("dwsbid", id);
		param.put("sblx", 2);
		Map<String, Object> dwsb=sbService.getDwsbById(id);
		DateUtil.fmtDate(dwsb);
		String tjsj=dwsb.get("TJSJ").toString();
		String[] nyr=tjsj.split("-");
		dwsb.put("YEAR", nyr[0]);
		dwsb.put("MONTH", nyr[1]);
		dwsb.put("DAY", nyr[2]);
		List<Map<String, Object>> data=sbService.getRysbxxList(param);
		DateUtil.fmtDate(data);
		request.setAttribute("dwsb", dwsb);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwcesbPrint";
	}
	//----------差额申报
	@RequestMapping("/rysbxxQuery")
	public String rysbxxQuery(HttpServletRequest request) {
		return "/zfhbbt/sb/rysbxxQuery";
	}
	@RequestMapping("/rysbxxPage")
	public void rysbxxPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryRysbxxPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/rysbxxEdit")
	public String rysbxxEdit(HttpServletRequest request) {
		String id = request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
			Map data = sbService.getRysbxx(id);
			DateUtil.fmtDate(data);
			request.setAttribute("data", data);
		}
		return "/zfhbbt/sb/rysbxxEdit";
	}
	@RequestMapping("/rysbxxDetail")
	public String rysbxxDetail(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map data = sbService.getRysbxx(id);
		DateUtil.fmtDate(data);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/rysbxxDetail";
	}
	@RequestMapping("/saveRysbxx")
	public void saveRysbxx(HttpServletRequest request, HttpServletResponse response) {
		Map data = ReqUtil.getParameterMap(request);
		sbService.saveRysbxx(data);
		Ajax.returnSuccess(response);
	}	
	@RequestMapping("/deleteRysbxx")
	public void deleteRysbxx(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		String DWSBID = request.getParameter("DWSBID");
		sbService.deleteRysbxx(ids, DWSBID);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/rysbHistory")
	public String rysbHistory(HttpServletRequest request){
		return "/zfhbbt/sb/rysbHistory";
	}
	@RequestMapping("/rysbHistoryPage")
	public void rysbHistoryPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = sbService.queryRysbHistoryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	@RequestMapping("/getLastRysb")
	public void getLastRysb(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		Map<String, Object> lastNd = sbService.getLastRysb(data);
		Ajax.returnData(lastNd, response);
	}
	//----------人员申报信息-------------
	
	//----------单位申报情况-------------
	@RequestMapping("/dwsbqkbEdit")
	public String dwsbqkbEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		Map<String, Object> data = sbService.getDwsbqkById(id);
		request.setAttribute("data", data);
		return "/zfhbbt/sb/dwsbqkbEdit";
	}	
	@RequestMapping("/saveDwsbqkb")
	public void saveDwsbqkb(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		sbService.updateDwsbqkb(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/dwsbqkbView")
	public String dwsbqkbView(HttpServletRequest request) {
		String id = request.getParameter("id");
		Map<String, Object> data = sbService.getDwsbqkById(id);
		request.setAttribute("data", data);	
		return "/zfhbbt/sb/dwsbqkbView";
	}
	//----------单位申报情况-------------
}
