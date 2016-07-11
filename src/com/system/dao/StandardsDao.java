package com.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface StandardsDao {

	List<Map> getStandardsList();
	
	/**
	 * 功能：
	 * @param standardForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> standardForm);
	
	/**
	 * 功能：
	 * @param standardForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> standardForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param standardForm
	 */
	void insert(Map<String, Object> standardForm);
	
	/**
	 * 功能：
	 * @param standardForm
	 */
	void update(Map<String, Object> standardForm);
	
	/**
	 * 功能：
	 * @param standardId
	 * @return
	 */
	Map<String, Object> getStandardById(String standardId);
	
	void cancelStandard(String standardId);
	
	void useStandard(String standardId);
	
	/**
	 * 功能：
	 * @param standardId
	 */
	void deleteStandard(String standardId);

	List<Map> getDwdmList();
	
	/**
	 * 功能：
	 * @param standardType
	 */
	void deleteStandardByType(String standardType);

	List<Map> getStdListByType(String type);

	List<Map> getZwzjdmList();
}
