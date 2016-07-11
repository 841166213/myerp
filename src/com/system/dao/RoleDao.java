/**
 * 
 */
package com.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.system.model.Menu;

/**
 * @author 闄堝妗�
 *
 */
public interface RoleDao {
	/**
	 * 鍔熻兘锛�
	 * @param roleForm
	 */
	void insert(Map<String, Object> roleForm);

	/**
	 * 鍔熻兘锛�
	 * @param roleForm
	 */
	void update(Map<String, Object> roleForm);

	/**
	 * 鍔熻兘锛�
	 * @param roleForm
	 * @return
	 */
	int queryPageCount(Map<String, Object> roleForm);

	/**
	 * 鍔熻兘锛�
	 * @param roleForm
	 * @param rowBounds
	 * @return
	 */
	List<Map<String, Object>> queryPage(Map<String, Object> roleForm, RowBounds rowBounds);

	/**
	 * 鍔熻兘锛�
	 * @param id
	 * @return
	 */
	List<Menu> getRoleMenus(@Param(value="menuId")String menuId, @Param(value="roleId")String roleId);

	/**
	 * 鍔熻兘锛�
	 * @param roleId
	 */
	void deleteRoleMenu(String roleId);

	/**
	 * 鍔熻兘锛�
	 * @param map
	 */
	void insertRoleMenu(Map<String, Object> map);

	/**
	 * 鍔熻兘锛�
	 * @param roleId
	 */
	void deleteRole(String roleId);

	/**
	 * 鍔熻兘锛�
	 * @param roleId
	 * @return
	 */
	Map<String, Object> getRoleById(String roleId);

	/**
	 * 鍔熻兘锛�
	 * @param roleId
	 * @return
	 */
	List<Map<String, Object>> getRoleMenuEditTree(String roleId);

	List<Map> getRoles();
}
