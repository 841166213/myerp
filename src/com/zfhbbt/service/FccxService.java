package com.zfhbbt.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.FcxxDao;

@Transactional(rollbackFor = Exception.class)
@Service("fcxxService")
public class FccxService {
	@Autowired
	private FcxxDao fcxxDao;

	public List<Map> fccxPpQuery(Map query) {
		return fcxxDao.fccxPpQuery(query);
	}


	public Page<Map<String, Object>> fccxQueryPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = fcxxDao.fccxQueryPageCount(query);
		List<Map<String, Object>> list = fcxxDao.fccxQueryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveFcxx(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			fcxxDao.update(data);
		}else{
			fcxxDao.insert(data);
		}
		
	}
	
	public Map<String, Object> getFcxxById(String fcxxId) {
		return fcxxDao.getFcxxById(fcxxId);
	}
	
	public void deleteFcxx(String[] ids) {
		for(String id: ids){
			fcxxDao.deleteFcxx(id);
		}
		
	}
	
	public void batchInsertJgdw(List<Map> list) {
		for(Map data: list){
			fcxxDao.insert(data);
		}
	}
}
