package com.system.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.system.dao.StandardsTypeDao;
@Transactional(rollbackFor = Exception.class)
@Service("standardsTypeService")
public class StandardsTypeService {
	@Autowired
	private StandardsTypeDao standardsTypeDao;
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = standardsTypeDao.queryPageCount(query);
		List<Map<String, Object>> list = standardsTypeDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveStandard(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			standardsTypeDao.update(data);
		}else{
			standardsTypeDao.insert(data);
		}
		
	}
	
	/**
	 * 功能：
	 * @param standardTypeId
	 * @return
	 */
	public Map<String, Object> getStandardTypeById(String standardTypeId) {
		return standardsTypeDao.getStandardTypeById(standardTypeId);
	}
	
	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteStandardsType(String[] ids) {
		for(String id: ids){
			standardsTypeDao.deleteStandardType(id);
		}		
	}
}
