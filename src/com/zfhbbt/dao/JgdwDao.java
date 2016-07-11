package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface JgdwDao {
	/**
	 * 功能：
	 * @param jgdwForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> jgdwForm);
	
	/**
	 * 功能：
	 * @param jgdwForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> jgdwForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param jgdwForm
	 */
	void insert(Map<String, Object> jgdwForm);
	
	/**
	 * 功能：
	 * @param jgdwForm
	 */
	void update(Map<String, Object> jgdwForm);
	
	/**
	 * 功能：
	 * @param jgdwId
	 * @return
	 */
	Map<String, Object> getJgdwById(String jgdwId);
	
	/**
	 * 功能：
	 * @param jgdwId
	 */
	void deleteJgdw(String jgdwId);
}
