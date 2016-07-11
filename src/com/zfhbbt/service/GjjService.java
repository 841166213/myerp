package com.zfhbbt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.GjjDao;
import com.zfhbbt.dao.JgdwDao;

@Transactional(rollbackFor = Exception.class)
@Service("gjjService")
public class GjjService {
	@Autowired
	private GjjDao gjjDao;
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryZhbgPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = gjjDao.queryZhbgPageCount(query);
		List<Map<String, Object>> list = gjjDao.queryZhbgPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveZhbg(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			gjjDao.updateDwzhbgb(data);
		}else{
			gjjDao.insertDwzhbgb(data);
		}
	}
	
	/**
	 * 功能：
	 * @param zhbgId
	 * @return
	 */
	public Map<String, Object> getZhbgById(String zhbgId) {
		return gjjDao.getZhbgById(zhbgId);
	}
	
	public Map<String, Object> getZhxxByDwid(String dwid) {
		return gjjDao.getZhxxByDwid(dwid);
	}

	public Page<Map<String, Object>> queryDwhcPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = gjjDao.queryDwhcPageCount(query);
		List<Map<String, Object>> list = gjjDao.queryDwhcPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public Map<String, Object> getDwdjById(String id) {
		return gjjDao.getDwdjById(id);
	}

	public Map<String, Object> getDwxxByDwsbId(String id) {
		return gjjDao.getDwxxByDwsbId(id);
	}

	public void saveDwdj(Map<String, Object> data) {
		if("update".equals(data.get("method"))){
			gjjDao.updateDwdj(data);
		}else if("add".equals(data.get("method"))){
			gjjDao.insertDwdj(data);
		}
	}
	
	public void zhbgCancel(String zhbgId) {
		gjjDao.deleteDwzhbgb(zhbgId);
	}
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryZgtqPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = gjjDao.queryZhbgPageCount(query);
		List<Map<String, Object>> list = gjjDao.queryZgtqPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveZgtq(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			gjjDao.updateZgtqsqb(data);
		}else{
			gjjDao.insertZgtqsqb(data);
		}
	}
	
	/**
	 * 功能：
	 * @param zgtqId
	 * @return
	 */
	public Map<String, Object> getZgtqById(String zgtqId) {
		return gjjDao.getZgtqById(zgtqId);
	}
	
	public void zgtqCancel(String zgtqId) {
		gjjDao.deleteZgtqsqb(zgtqId);
	}

	public void dwdjSubmit(String id) {
		gjjDao.dwdjSubmit(id);
		
		
	}

}
