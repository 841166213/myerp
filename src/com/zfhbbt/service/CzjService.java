package com.zfhbbt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.CzjDao;
import com.zfhbbt.dao.GdDao;
import com.zfhbbt.dao.SbDao;

@Transactional(rollbackFor = Exception.class)
@Service("czjService")
public class CzjService {
	@Autowired
	private SbDao sbDao;
	@Autowired
	private CzjDao czjDao;
	@Autowired
	private GdDao gdDao;

	public void czjPass(Map<String, Object> data) {
		data.put("SHZT_CZJ", "1");
		sbDao.updateDwsbxxb(data);
		
		String dwsbId = (String) data.get("ID");
		sbxxGdByDwsbId(dwsbId);//申报信息归档
	}

	private void sbxxGdByDwsbId(String dwsbId) {
		gdDao.sbxxGdByDwsbId(dwsbId);//通过dwsbId归档rysbxx
		gdDao.resetRygdxxZxbzByDwsbId(dwsbId);//通过dwsbId重置人员归档信息最新标志
		
	}

	public Page<Map<String, Object>> queryZjhbpcPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = czjDao.queryZjhbpcPageCount(query);
		List<Map<String, Object>> list = czjDao.queryZjhbpcPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public void addZjbkpc(Map<String, Object> data) {
		String id = czjDao.getZjbkpcbNextId();
		data.put("ID", id);
		czjDao.insertZjbkpcb(data);
		
		Map data2 = new HashMap();
		data2.put("ZJHBPC_ID", id);
		String[] ids = ((String) data.get("ids")).split(",");
		if(ids != null){
			for(String ID : ids){
				data2.put("ID", ID);
				sbDao.updateDwsbxxb(data2);
			}
		}
		czjDao.updatePcJeAndMxs(data2);
	}

	public List<Map> getZjhbpcmxList(Map<String, Object> data) {
		return czjDao.getZjhbpcmxList(data);
	}

	public void updateZjhbpc(Map<String, Object> data) {
		czjDao.updateZjhbpc(data);

	}

	public Map<String, Object> getZjhbpcById(String id) {
		return czjDao.getZjhbpcById(id);
	}

	public void cancelZjhbpcMx(Map<String, Object> data) {
		String id = (String) data.get("id");
		czjDao.cancelZjhbpcMx(id);
		
		//更新划拨金额和明细数
		czjDao.updatePcJeAndMxs(data);
	}

	public void addZjhbpcmx(Map<String, Object> data) {
		String[] ids = (String[]) data.get("ids[]");
		if(ids != null){
			for(String ID : ids){
				data.put("ID", ID);
				sbDao.updateDwsbxxb(data);
			}
		}
		//更新划拨金额和明细数
		czjDao.updatePcJeAndMxs(data);
	}

	public void zjhbpcCancel(String id) {
		czjDao.zjhbpcCancel(id);
		czjDao.deleteZjhbpc(id);
	}

	public List<Map> getZjhbListByIds(Map<String, Object> data) {
		return czjDao.getZjhbListByIds(data);
	}
}
