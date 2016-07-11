/**
 * 
 */
package com.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.system.model.Menu;

/**
 * @author 闄堝妗�
 *
 */
public interface MenuDao {

	/**
	 * 鍔熻兘锛�
	 * @param id
	 * @return
	 */
	List<Map<String, Object>> getMenuByFatherId(String id);

	/**
	 * 鍔熻兘锛�
	 * @return
	 */
	List<Menu> getFirstLevelMenu();

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @return
	 */
	int queryFirstLevelPageCount(Map<String, Object> query);

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryFirstLevelPage(Map<String, Object> query,
			RowBounds rowBounds);

	/**
	 * 鍔熻兘锛�
	 * @param id
	 */
	void delete(String id);

	/**
	 * 鍔熻兘锛�
	 * @param data
	 */
	void update(Map<String, Object> data);

	/**
	 * 鍔熻兘锛�
	 * @param data
	 */
	void insert(Map<String, Object> data);

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @return
	 */
	int querySecondLevelPageCount(Map<String, Object> query);

	/**
	 * 鍔熻兘锛�
	 * @param query
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> querySecondLevelPage(Map<String, Object> query,
			RowBounds rowBounds);
	
	/**
	 * 鍔熻兘锛�
	 * @param menuForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> menuForm);
	
	/**
	 * 鍔熻兘锛�
	 * @param menuForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> menuForm, RowBounds rowBounds);
	
	/**
	 * 鍔熻兘锛�
	 * @param menuId
	 * @return
	 */
	Map<String, Object> getMenuById(String menuId);
	
	List<Map<String, Object>> getAllMenu();
	
	List<Menu> getMenuByUserId(String roleId);

	List<Map<String, Object>> getLevelMenu(String level);

}
