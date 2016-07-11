package com.zfhbbt.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.GdDao;
import com.zfhbbt.dao.SbDao;

@Transactional(rollbackFor = Exception.class)
@Service("sbService")
public class SbService {
	@Autowired
	private SbDao sbDao;
	@Autowired
	private GdDao gdDao;

	public Page<Map<String, Object>> queryDwsbPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = sbDao.queryDwsbPageCount(query);
		List<Map<String, Object>> list = sbDao.queryDwsbPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public void addDwsb(Map<String, Object> data) {
		sbDao.insertDwsbxx(data);
		
	}

	public Page<Map<String, Object>> queryDwqesbPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = sbDao.queryDwqesbPageCount(query);
		List<Map<String, Object>> list = sbDao.queryDwqesbPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public Page<Map<String, Object>> queryDwcesbPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = sbDao.queryDwcesbPageCount(query);
		List<Map<String, Object>> list = sbDao.queryDwcesbPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public Map getRysbxx(String id) {
		return sbDao.getRysbxx(id);
	}

	public void saveRysbxx(Map data) {
		String ID = (String) data.get("ID");
		if(StringUtils.isBlank(ID)){
			sbDao.insertRysbxx(data);
		}else{
			sbDao.updateRysbxx(data);
		}
		Map<String, Object> BND_sbqk=sbDao.calBNDSbqk(data.get("DWSBID").toString());
		BND_sbqk.put("DWSBID", data.get("DWSBID"));
		updateDwsbqkb(BND_sbqk);
	}
	
	public Map<String, Object> getDwsbqkById(String sbId) {
		return sbDao.getDwsbqkById(sbId);
	}
	
	public void updateDwsbqkb(Map<String, Object> data){
		sbDao.updateDwsbqkb(data);
	}

	public void deleteRysbxx(String[] ids, String DWSBID) {
		for(String id: ids){
			sbDao.deleteRysbxx(id);
		}
		Map<String, Object> BND_sbqk=sbDao.calBNDSbqk(DWSBID);
		BND_sbqk.put("DWSBID", DWSBID);
		updateDwsbqkb(BND_sbqk);
	}
	
	public void doSubmit(Map<String, Object> data){
		sbDao.updateDwsbxxb(data);
	}
	
	public void batchInsertRysbxx(List<Map> list, String sbdwxxid) {
		for(Map data: list){
			sbDao.insertRysbxx(data);
		}
		Map<String, Object> BND_sbqk=sbDao.calBNDSbqk(sbdwxxid);
		BND_sbqk.put("DWSBID", sbdwxxid);
		updateDwsbqkb(BND_sbqk);
	}

	public void batchVerifyRyxx(Map<String, Object> data) {
		String[] ids = (String[]) data.get("ids[]");
		if(ids != null){
			for(String ID : ids){
				data.put("ID", ID);
				sbDao.updateRysbxx(data);
			}
		}
		
	}

	public Page<Map<String, Object>> queryRysbxxPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = sbDao.queryRysbxxPageCount(query);
		List<Map<String, Object>> list = sbDao.queryRysbxxPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public void batchVerifySbxx(Map<String, Object> data) {
		String[] ids = (String[]) data.get("ids[]");
		if(ids != null){
			for(String ID : ids){
				data.put("ID", ID);
				sbDao.updateRysbxx(data);
			}
		}
		
	}
	
	public Page<Map<String, Object>> queryRysbHistoryPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = sbDao.queryRysbHistoryPageCount(query);
		List<Map<String, Object>> list = sbDao.queryRysbHistoryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public Map getDwsbById(String id) {
		return sbDao.getDwsbById(id);
	}
	
	public Map getLastRysb(Map data) {
		return gdDao.getLastRygdxx(data);
	}
	
	public List<Map<String, Object>> getRysbxxList(Map data){
		return sbDao.getRysbxxList(data);
	}

	public void deleteDwsb(String id) {
		sbDao.deleteRysbxxByDwsbId(id);
		sbDao.deleteDwsbqk(id);
		sbDao.deleteDwsbxx(id);
		
	}

}
