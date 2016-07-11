/**
 * 
 */
package com.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.system.model.SessionUser;

/**
 * @author 闄堝妗�
 *
 */
public interface UserDao {

	/**
	 * 鍔熻兘锛�
	 * @param userForm
	 */
	void insert(Map<String, Object> userForm);

	/**
	 * 鍔熻兘锛�
	 * @param userForm
	 */
	void update(Map<String, Object> userForm);

	/**
	 * 鍔熻兘锛�
	 * @param userId
	 * @return
	 */
	List<Map<String, Object>> getUserRole(String userId);

	/**
	 * 鍔熻兘锛�
	 * @param userId
	 */
	void deleteUserRole(String userId);

	/**
	 * 鍔熻兘锛�
	 * @param map
	 */
	void insertUserRole(Map<String, Object> map);

	/**
	 * 鍔熻兘锛�
	 * @param userId
	 * @return
	 */
	Map<String, Object> getUser(String userId);

	/**
	 * 鍔熻兘锛�
	 * @param userId
	 */
	void deleteUser(String userId);

	List<Map<String, Object>> queryUserPage(Map<String, Object> query, RowBounds rowBounds);

	int queryUserPageCount(Map<String, Object> query);

	List<Map> getUserRoles(String id);

	Map<String, Object> getUserByAccount(String account);
	
	SessionUser getUserByAccountPs(Map<String, Object> data);

}
