package com.zfhbbt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

public interface FcxxDao {
	//匹配查询
	List<Map> fccxPpQuery(Map query);

	List<Map<String, Object>> fccxQueryPage(Map<String, Object> query, RowBounds rowBounds);

	int fccxQueryPageCount(Map<String, Object> query);
	
	void insert(Map<String, Object> fcxxForm);
	
	void update(Map<String, Object> fcxxForm);
	
	Map<String, Object> getFcxxById(String fcxxId);
	
	void deleteFcxx(String fcxxId);

}
