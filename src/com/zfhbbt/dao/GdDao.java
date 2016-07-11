package com.zfhbbt.dao;

import java.util.Map;

public interface GdDao {
	
	void sbxxGdByDwsbId(String dwsbId);

	void resetRygdxxZxbzByDwsbId(String dwsbId);

	Map getLastRygdxx(Map data);
}
