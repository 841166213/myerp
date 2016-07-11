package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface ZwzjDao {
	/**
	 * 功能：
	 * @param zwzjForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> zwzjForm);
	
	/**
	 * 功能：
	 * @param zwzjForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> zwzjForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param zwzjForm
	 */
	void insert(Map<String, Object> zwzjForm);
	
	/**
	 * 功能：
	 * @param zwzjForm
	 */
	void update(Map<String, Object> zwzjForm);
	
	/**
	 * 功能：
	 * @param zwzjId
	 * @return
	 */
	Map<String, Object> getZwzjById(String jgdwId);
	
	/**
	 * 功能：
	 * @param zwzjId
	 */
	void deleteZwzj(String zwzjId);

	Map getZwzjByZw(String zw);
}
