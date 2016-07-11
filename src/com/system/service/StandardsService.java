package com.system.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.common.util.DateUtil;
import com.common.util.StringUtil;
import com.system.dao.StandardsDao;
@Transactional(rollbackFor = Exception.class)
@Service("standardsService")
public class StandardsService {
	@Autowired
	private StandardsDao standardsDao;

	public Map<String, List<Map>> getInitStandards() {
		List<Map> stdList = standardsDao.getStandardsList();
		//按type封装成Map<String, List<Map>>
		Map map = new HashMap();
		if(stdList != null && stdList.size() > 0){
			String currentType = (String) stdList.get(0).get("TYPE");
			List list = new ArrayList();
			for(int i=0; i<stdList.size(); i++){
				Map item = stdList.get(i);
				String type = (String) item.get("TYPE");
				
				if(!currentType.equals(type)){
					map.put(currentType, list);
					currentType = type;
					list = new ArrayList();
				}
				
				list.add(item);
			}
			
			map.put(currentType, list);
		}
		//加载单位代码
		List<Map> dwdmList = getDwdmList();
		map.put("jgdw", dwdmList);
		//加载年度
		List<Map> ndList = DateUtil.getYearSelectMap();
		map.put("nd", ndList);
		//加载职务职级
		List<Map> zwzjdmList = standardsDao.getZwzjdmList();
		map.put("zwzj", zwzjdmList);
		return map;
	}

	public Map<String, Map> changeToMap(Map<String, List<Map>> stdList) {
		Map<String, Map> map = new HashMap<String, Map>();
		for(String key : stdList.keySet()){
			List<Map> list = stdList.get(key);
			Map map2 = listToMap(list);
			map.put(key, map2);
		}
		return map;
	}
	public Map<String, Map> changeToMap_turn(Map<String, List<Map>> stdList) {
		Map<String, Map> map = new HashMap<String, Map>();
		for(String key : stdList.keySet()){
			List<Map> list = stdList.get(key);
			Map map2 = listToMap_turn(list);
			map.put(key, map2);
		}
		return map;
	}
	public Map listToMap(List<Map> list) {
		Map map = new HashMap();
		for(Map map3:  list){
			map.put(map3.get("VALUE"), map3.get("TEXT"));
		}
		return map;
	}
	public Map listToMap_turn(List<Map> list) {
		Map map = new HashMap();
		for(Map map3:  list){
			map.put(map3.get("TEXT"), map3.get("VALUE"));
		}
		return map;
	}
	
	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = standardsDao.queryPageCount(query);
		List<Map<String, Object>> list = standardsDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	public void saveStandard(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			standardsDao.update(data);
		}else{
			standardsDao.insert(data);
		}
		
	}
	
	/**
	 * 功能：
	 * @param standardId
	 * @return
	 */
	public Map<String, Object> getStandardById(String standardId) {
		return standardsDao.getStandardById(standardId);
	}
	
	public void cancelStandard(String standardId){
		standardsDao.cancelStandard(standardId);
	}
	
	public void useStandard(String standardId){
		standardsDao.useStandard(standardId);
	}
	
	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteStandards(String[] ids) {
		for(String id: ids){
			standardsDao.deleteStandard(id);
		}		
	}
	
	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteStandardsByType(String[] types) {
		for(String type: types){
			standardsDao.deleteStandardByType(type);
		}		
	}

	public List<Map> getDwdmList() {
		return standardsDao.getDwdmList();
	}

	public List<Map> getStdListByType(String type) {
		return standardsDao.getStdListByType(type);
	}
}
