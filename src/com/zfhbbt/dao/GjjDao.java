package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface GjjDao {
	/**
	 * 功能：
	 * @param zhbgForm
	 * @return
	 */
	int queryZhbgPageCount(Map<String, Object> zhbgForm);
	
	/**
	 * 功能：
	 * @param zhbgForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryZhbgPage(Map<String, Object> zhbgForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param zhbgForm
	 */
	void insertDwzhbgb(Map<String, Object> zhbgForm);
	
	void updateDwzhbgb(Map<String, Object> zhbgForm);
	
	/**
	 * 功能：
	 * @param zhbgId
	 * @return
	 */
	Map<String, Object> getZhbgById(String zhbgId);
	
	/**
	 * 功能：
	 * @param dwid
	 * @return
	 */
	Map<String, Object> getZhxxByDwid(String dwid);

	List<Map<String, Object>> queryDwhcPage(Map<String, Object> query, RowBounds rowBounds);

	int queryDwhcPageCount(Map<String, Object> query);

	Map<String, Object> getDwdjById(String id);

	Map<String, Object> getDwxxByDwsbId(String id);

	void updateDwdj(Map<String, Object> data);

	void insertDwdj(Map<String, Object> data);
	
	void deleteDwzhbgb(String zhbgId);
	
	/**
	 * 功能：
	 * @param zgtqForm
	 * @return
	 */
	int queryZgtqPageCount(Map<String, Object> zgtqForm);
	
	/**
	 * 功能：
	 * @param zgtqForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryZgtqPage(Map<String, Object> zgtqForm, RowBounds rowBounds);
	
	/**
	 * 功能：
	 * @param zgtqForm
	 */
	void insertZgtqsqb(Map<String, Object> zgtqForm);
	
	/**
	 * 功能：
	 * @param zgtqForm
	 */
	void updateZgtqsqb(Map<String, Object> zgtqForm);
	
	/**
	 * 功能：
	 * @param zgtqId
	 * @return
	 */
	Map<String, Object> getZgtqById(String zgtqId);
	
	void deleteZgtqsqb(String zgtqId);
	/**
	 * 功能：提交单位登记
	 * @param id
	 * @return
	 */
	void dwdjSubmit(String id);
}
