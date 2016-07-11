package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface SbDao {

	int queryDwsbPageCount(Map<String, Object> query);

	List<Map<String, Object>> queryDwsbPage(Map<String, Object> query, RowBounds rowBounds);

	void insertDwsbxx(Map<String, Object> data);

	List<Map<String, Object>> queryDwqesbPage(Map<String, Object> query, RowBounds rowBounds);

	int queryDwqesbPageCount(Map<String, Object> query);
	
	List<Map<String, Object>> queryDwcesbPage(Map<String, Object> query, RowBounds rowBounds);

	int queryDwcesbPageCount(Map<String, Object> query);
	
	Map<String, Object> getDwsbqkById(String sbId);
	
	void updateDwsbqkb(Map<String, Object> sbForm);

	Map getRysbxx(String id);

	void insertRysbxx(Map data);

	void updateRysbxx(Map data);

	void deleteRysbxx(String id);
	
	Map<String, Object> calBNDSbqk(String dwsbid);

	void updateDwsbxxb(Map<String, Object> data);

	List<Map<String, Object>> queryRysbxxPage(Map<String, Object> query, RowBounds rowBounds);

	int queryRysbxxPageCount(Map<String, Object> query);
	
	int queryRysbHistoryPageCount(Map<String, Object> query);

	List<Map<String, Object>> queryRysbHistoryPage(Map<String, Object> query, RowBounds rowBounds);

	Map getDwsbById(String id);
	
	Map getLastRysb(Map data);
	
	List<Map<String, Object>> getRysbxxList(Map data);

	void deleteRysbxxByDwsbId(String id);

	void deleteDwsbqk(String id);

	void deleteDwsbxx(String id);

}
