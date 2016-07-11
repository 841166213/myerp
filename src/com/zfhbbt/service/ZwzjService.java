package com.zfhbbt.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.ZwzjDao;

@Transactional(rollbackFor = Exception.class)
@Service("zwzjService")
public class ZwzjService {
	@Autowired
	private ZwzjDao zwzjDao;
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = zwzjDao.queryPageCount(query);
		List<Map<String, Object>> list = zwzjDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveZwzj(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			zwzjDao.update(data);
		}else{
			zwzjDao.insert(data);
		}
		
	}
	
	/**
	 * 功能：
	 * @param zwzjId
	 * @return
	 */
	public Map<String, Object> getZwzjById(String zwzjId) {
		return zwzjDao.getZwzjById(zwzjId);
	}
	
	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteZwzj(String[] ids) {
		for(String id: ids){
			zwzjDao.deleteZwzj(id);
		}
		
	}

	public Map getZwzjByZw(String zw) {
		return zwzjDao.getZwzjByZw(zw);
	}
}
