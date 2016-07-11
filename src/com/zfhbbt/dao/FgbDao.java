package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface FgbDao {

	List<Map<String, Object>> queryFgbVerifyPage(Map<String, Object> query, RowBounds rowBounds);

	int queryFgbVerifyPageCount(Map<String, Object> query);
	
	void submitVerify(String id);

	List<Map> getRysbxxListByIds(Map<String, Object> data);

}
