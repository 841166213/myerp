package com.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface StandardsTypeDao {
	
	/**
	 * 功能：
	 * @param standardTypeForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> standardTypeForm);
	
	/**
	 * 功能：
	 * @param standardTypeForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> standardTypeForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param standardTypeForm
	 */
	void insert(Map<String, Object> standardTypeForm);
	
	/**
	 * 功能：
	 * @param standardTypeForm
	 */
	void update(Map<String, Object> standardTypeForm);
	
	/**
	 * 功能：
	 * @param standardTypeId
	 * @return
	 */
	Map<String, Object> getStandardTypeById(String standardTypeId);
	
	/**
	 * 功能：
	 * @param standardTypeId
	 */
	void deleteStandardType(String standardTypeId);
}
