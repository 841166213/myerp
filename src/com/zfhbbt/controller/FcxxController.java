package com.zfhbbt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.ExcelUtil;
import com.common.util.ReqUtil;
import com.zfhbbt.service.FccxService;

import jxl.Cell;
import jxl.JXLException;
import jxl.Sheet;
import jxl.Workbook;

@Controller
@RequestMapping("/fcxx")
public class FcxxController {
	@Autowired
	private FccxService fcxxService;
	
	@RequestMapping("/manage")
	public String fcxxManage() {
		return "/zfhbbt/fcxx/fcxxManage";
	}
	@RequestMapping("/importQuery")
	public String importQuery() {
		return "/zfhbbt/fcxx/importQuery";
	}
	@RequestMapping("/fcxxQuery")
	public String fccxQuery() {
		return "/zfhbbt/fcxx/fcxxQuery";
	}
	@RequestMapping("/edit")
	public String fcxxEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = fcxxService.getFcxxById(id);
			request.setAttribute("data", data);
		}
		return "/zfhbbt/fcxx/fcxxEdit";
	}
	@RequestMapping("/save")
	public void saveFcxx(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		fcxxService.saveFcxx(data);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		fcxxService.deleteFcxx(ids);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/downloadFcxxImportModel")
	public String downloadFcxxImportModel(HttpServletRequest request, HttpServletResponse response) {
		return "forward:/comm/downloadImportModel?fileName=房产信息导入模版.xls";
	}
	@RequestMapping("/importFcxx")
	public void importFcxx(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws JXLException, IOException {
		String fileName = file.getOriginalFilename();
		String[] heads = {"姓名", "身份证", "配偶姓名", "配偶身份证", "单位", "面积", "地址"};
		String[] keys = {"XM", "SFZ", "POXM", "POSFZ", "DW", "MJ", "DZ"};
		
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
		int rowCount = sheet.getRows();	//获取总行数
		for (int i = 1; i < rowCount; i++) {
			data = new HashMap();
			cells = sheet.getRow(i);
			for(int j=0; j<keys.length; j++){
				data.put(keys[j], ExcelUtil.getCellContent(cells,j));
			}
			list.add(data);
		}
		fcxxService.batchInsertJgdw(list);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/importQueryData")
	public void importQueryData(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws JXLException, IOException {
		String[] heads = {"姓名", "身份证", "配偶姓名", "配偶身份证"};
		String[] keys = {"XM", "SFZ", "POXM", "POSFZ"};
		
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
		int rowCount = sheet.getRows();	//获取总行数
		for (int i = 1; i < rowCount; i++) {
			data = new HashMap();
			data.put("ID", i-1);
			cells = sheet.getRow(i);
			for(int j=0; j<keys.length; j++){
				data.put(keys[j], ExcelUtil.getCellContent(cells,j));
			}
			list.add(data);
		}
		//request.getSession().setAttribute(SessionUtil.session_importList_key, list);
		Ajax.returnData(list, response);
		
	}
	@RequestMapping("/importQueryResult")
	public String importQueryResult(HttpServletRequest request, HttpServletResponse response) {
		return "/zfhbbt/fcxx/importQueryResult";
		
	}
	@RequestMapping("/importQueryResultData")
	public void importQueryResultData(HttpServletRequest request, HttpServletResponse response) {
		
		String SFZ = request.getParameter("SFZ");
		String XM = request.getParameter("XM");
		
		Map query1 = new HashMap(2);
		query1.put("SFZ", SFZ);
		query1.put("XM", XM);
		if(SFZ.length() == 15){
			String SFZ_6 = SFZ.substring(6, 12);
			query1.put("SFZ_6", SFZ_6);
		}
		if(SFZ.length() == 18){
			String SFZ_6 = SFZ.substring(8, 14);
			query1.put("SFZ_6", SFZ_6);
		}
		List<Map> list1 = fcxxService.fccxPpQuery(query1);
		
		SFZ = request.getParameter("POSFZ");
		XM = request.getParameter("POXM");
		Map query2 = new HashMap(2);
		query2.put("SFZ", SFZ);
		query2.put("XM", XM);
		if(SFZ.length() == 15){
			String SFZ_6 = SFZ.substring(6, 12);
			query2.put("SFZ_6", SFZ_6);
		}
		if(SFZ.length() == 18){
			String SFZ_6 = SFZ.substring(8, 14);
			query2.put("SFZ_6", SFZ_6);
		}
		List<Map> list2 = fcxxService.fccxPpQuery(query2);
		
		Map data = new HashMap(2);
		data.put("list1", list1);
		data.put("list2", list2);
		
		Ajax.returnData(data, response);
		
	}
	
	@RequestMapping("/fcxxQueryPage")
	public void fcxxQueryPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = fcxxService.fccxQueryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
}
