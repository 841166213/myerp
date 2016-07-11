package com.zfhbbt.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zfhbbt.dao.SbDao;

@Transactional(rollbackFor = Exception.class)
@Service("bwbService")
public class BwbService {
	@Autowired
	private SbDao sbDao;

	public void bwbPass(Map<String, Object> data) {
		data.put("SHZT_BWB", "1");
		sbDao.updateDwsbxxb(data);
	}
}
