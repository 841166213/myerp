package com.zfhbbt.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.JgdwDao;

@Transactional(rollbackFor = Exception.class)
@Service("jgdwService")
public class JgdwService {
	@Autowired
	private JgdwDao jgdwDao;
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = jgdwDao.queryPageCount(query);
		List<Map<String, Object>> list = jgdwDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveJgdw(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			jgdwDao.update(data);
		}else{
			jgdwDao.insert(data);
		}
		
	}
	
	/**
	 * 功能：
	 * @param jgdwId
	 * @return
	 */
	public Map<String, Object> getJgdwById(String jgdwId) {
		return jgdwDao.getJgdwById(jgdwId);
	}
	
	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteJgdw(String[] ids) {
		for(String id: ids){
			jgdwDao.deleteJgdw(id);
		}
		
	}

	public void batchInsertJgdw(List<Map> list) {
		for(Map data: list){
			jgdwDao.insert(data);
		}
	}
}
