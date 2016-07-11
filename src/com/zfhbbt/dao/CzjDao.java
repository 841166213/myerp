package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface CzjDao {

	List<Map<String, Object>> queryZjhbpcPage(Map<String, Object> query, RowBounds rowBounds);

	int queryZjhbpcPageCount(Map<String, Object> query);

	void addZjbkpc();

	void insertZjbkpcb(Map<String, Object> data);

	List<Map> getZjhbpcmxList(Map<String, Object> data);

	void updateZjhbpc(Map<String, Object> data);

	Map<String, Object> getZjhbpcById(String id);

	Object cancelZjhbpcMx(String id);

	void zjhbpcCancel(String id);

	void deleteZjhbpc(String id);

	void updatePcJeAndMxs(Map<String, Object> data);

	List<Map> getZjhbListByIds(Map<String, Object> data);

	String getZjbkpcbNextId();

}
