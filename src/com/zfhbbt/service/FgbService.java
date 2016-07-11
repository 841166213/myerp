package com.zfhbbt.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.zfhbbt.dao.FgbDao;
import com.zfhbbt.dao.GdDao;
import com.zfhbbt.dao.SbDao;

@Transactional(rollbackFor = Exception.class)
@Service("fgbService")
public class FgbService {
	@Autowired
	private SbDao sbDao;
	@Autowired
	private FgbDao fgbDao;
	@Autowired
	private GdDao gdDao;

	public Page<Map<String, Object>> queryFgbVerifyPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = fgbDao.queryFgbVerifyPageCount(query);
		List<Map<String, Object>> list = fgbDao.queryFgbVerifyPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public void fgbDwsbqkPass(Map<String, Object> data) {
		data.put("SHZT_FGB_SBQK", "1");
		sbDao.updateDwsbqkb(data);
	}
	
	public void submitVerify(String id){
		fgbDao.submitVerify(id);
	}

	public List<Map> getRysbxxHistoryCheckList(Map<String, Object> data) {
		List<Map> list = fgbDao.getRysbxxListByIds(data);
		List<Map> list2 = new ArrayList<Map>();
		for(Map item : list){
			item.put("level", "0");
			item.put("expanded", false);
			
			Map<String, Object> item2 = gdDao.getLastRygdxx(item);
			if(item2 != null){
				item.put("isLeaf", false);
				
				for(Map.Entry<String, Object> entry : item2.entrySet()){
					item.put(entry.getKey() + "_OLD", entry.getValue());
				}   
				
				item2.put("level", "1");
				item2.put("isLeaf", true);
				item2.put("expanded", false);
				item2.put("parent", item.get("ID"));
				list2.add(item2);
			}else{
				item.put("isLeaf", true);
			}
		}
		list.addAll(list2);
		return list;
	}

}
