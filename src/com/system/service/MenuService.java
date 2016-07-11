/**
 * 
 */
package com.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.common.mybatis.page.Page;
import com.common.util.StringUtil;
import com.system.dao.MenuDao;
import com.system.model.Menu;

/**
 * @author 闄堝妗�
 *
 */
@Transactional(rollbackFor = Exception.class)
@Service("menuService")
public class MenuService {
	@Autowired
	private MenuDao menuDao;

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryFirstLevelPage(
			Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = menuDao.queryFirstLevelPageCount(query);
		List<Map<String, Object>> list = menuDao.queryFirstLevelPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	/**
	 * 鍔熻兘锛�
	 * @param ids
	 */
	public void delete(String[] ids) {
		for(String id: ids){
			menuDao.delete(id);
		}
		
	}

	/**
	 * 鍔熻兘锛�
	 * @param data
	 */
	public void save(Map<String, Object> data) {
		if(StringUtil.isEmpty((String) data.get("ID"))){
			menuDao.insert(data);
		}else{
			menuDao.update(data);
		}
		
	}

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> querySecondLevelPage(
			Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = menuDao.querySecondLevelPageCount(query);
		List<Map<String, Object>> list = menuDao.querySecondLevelPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	/**
	 * 鍔熻兘锛�
	 * @return
	 */
	public List<Menu> getFirstLevelMenu() {
		// TODO Auto-generated method stub
		return menuDao.getFirstLevelMenu();
	}
	
	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = menuDao.queryPageCount(query);
		List<Map<String, Object>> list = menuDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}
	
	/**
	 * 鍔熻兘锛�
	 * @param menuId
	 * @return
	 */
	public Map<String, Object> getMenuById(String menuId) {
		return menuDao.getMenuById(menuId);
	}
	
	public void cancelMenu(String menuId){
		Map data = new HashMap();
		data.put("ID", menuId);
		data.put("IS_DEFAULT", 1);
		menuDao.update(data);
	}
	
	public void useMenu(String menuId){
		Map data = new HashMap();
		data.put("ID", menuId);
		data.put("IS_DEFAULT", 0);
		menuDao.update(data);
	}
	
	public List<Map<String, Object>> getAllMenu(){
		return menuDao.getAllMenu();
	}

	public List<Map<String, Object>> getLevelMenu(String level) {
		return menuDao.getLevelMenu(level);
	}

}
