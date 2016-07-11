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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.common.listener.InitListener;
import com.common.mybatis.page.Page;
import com.common.mybatis.page.PageUtil;
import com.common.util.Ajax;
import com.common.util.ExcelUtil;
import com.common.util.ReqUtil;
import com.system.service.StandardsService;
import com.zfhbbt.service.JgdwService;

import jxl.Cell;
import jxl.JXLException;
import jxl.Sheet;
import jxl.Workbook;

@Controller
@RequestMapping("/jgdw")
public class JgdwController {
	
	@Autowired
	private JgdwService jgdwService;
	@Autowired
	private StandardsService standardsService;
	
	@RequestMapping("/manage")
	public String jgdwManage() {
		return "/zfhbbt/jgdw/jgdwManage";
	}
	@RequestMapping("/jgdwTreeManage")
	public String jgdwTreeManage() {
		return "/zfhbbt/jgdw/jgdwTreeManage";
	}
	
	@RequestMapping("/page")
	public void getJgdwPage(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> query = ReqUtil.getParameterMap(request);
		int currentPage = PageUtil.getCurrentPage(request);
		int pageSize = PageUtil.getPageSize(request);
		Page<Map<String, Object>> page = jgdwService.queryPage(
				query, currentPage, pageSize);
		Ajax.returnPage(page, response);
	}
	
	@RequestMapping("/edit")
	public String jgdwEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		if(id != null){//不为空时修改，为空时新增
			Map<String, Object> data = jgdwService.getJgdwById(id);
			request.setAttribute("data", data);
		}
		return "/zfhbbt/jgdw/jgdwEdit";
	}
	
	@RequestMapping("/save")
	public void saveJgdw(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = ReqUtil.getParameterMap(request);
		jgdwService.saveJgdw(data);
		refreshInitJgdwDm(request);
		Ajax.returnSuccess(response);
	}
	//刷新机关单位代码缓存
	private void refreshInitJgdwDm(HttpServletRequest request) {
		Map<String, List<Map>> stdList = (Map<String, List<Map>>) request.getSession().getServletContext().getAttribute(InitListener.STD_LIST);
		Map<String, Map> stdMap = (Map<String, Map>) request.getSession().getServletContext().getAttribute(InitListener.STD_MAP);
		List<Map> dwdmList = standardsService.getDwdmList();
		stdList.put("jgdw", dwdmList);
		stdMap.put("jgdw", standardsService.listToMap(dwdmList));
	}
	
	@RequestMapping("/doDelete")
	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		String[] ids = request.getParameterValues("ids[]");
		jgdwService.deleteJgdw(ids);
		refreshInitJgdwDm(request);
		Ajax.returnSuccess(response);
	}
	@RequestMapping("/downloadJgdwImportModel")
	public String downloadJgdwImportModel(HttpServletRequest request, HttpServletResponse response) {
		return "forward:/comm/downloadImportModel?fileName=机关单位信息导入模版.xls";
	}
	@RequestMapping("/importJgdw")
	public void importJgdw(@RequestParam(value = "file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws JXLException, IOException {
		String fileName = file.getOriginalFilename();
		String[] heads = {"单位名称", "组织机构代码", "单位性质", "单位经费来源", "单位法人代码",
				"所属区县", "单位所在地址", "邮政编码", "主管部门", "编制人数",
				"账户名称", "开户银行", "银行账号"};
		String[] keys = {"DWMC", "ZZJGDM", "DWXZ", "DWJFLY", "DWFRDM",
				"SSQX", "DWSZDZ", "YZBM", "ZGBM", "BZRS",
				"ZHMC", "KHYH", "YHZH"};
		
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
			Map<String, Map> stdMap = (Map<String, Map>)request.getSession().getServletContext().getAttribute("STD_MAP_turn");
			for(int j=0; j<keys.length; j++){
				String cellContent = ExcelUtil.getCellContent(cells,j);
				if(j == 2){
					data.put(keys[j], stdMap.get("sb_dwxz").get(cellContent));
				}else if(j == 3){
					data.put(keys[j], stdMap.get("dw_jfly").get(cellContent));
				}else if(j == 5){
					data.put(keys[j], stdMap.get("stqx").get(cellContent));
				}else{
					data.put(keys[j], cellContent);
				}				
			}
			list.add(data);
		}
		jgdwService.batchInsertJgdw(list);
		Ajax.returnSuccess(response);
	}
}
