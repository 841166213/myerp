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
import com.system.dao.RoleDao;
import com.system.model.Menu;

/**
 * @author 陈家桂
 *
 */

@Transactional(rollbackFor = Exception.class)
@Service("roleService")
public class RoleService {
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;

	/**
	 * 功能：
	 * @param query
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public Page<Map<String, Object>> queryPage(Map<String, Object> query,
			int currentPage, int pageSize) {
		int totalRow = roleDao.queryPageCount(query);
		List<Map<String, Object>> list = roleDao.queryPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	/**
	 * 功能：
	 * @param ids
	 */
	public void deleteRoles(String[] ids) {
		for(String id: ids){
			roleDao.deleteRole(id);
		}
		
	}

	/**
	 * 功能：
	 * @param roleId
	 * @return
	 */
	public List<Menu> getRoleMenus(String roleId) {
		List<Menu> list = menuDao.getFirstLevelMenu();
		for(Menu item : list){
			item.setChildren(roleDao.getRoleMenus(item.getId(), roleId));
		}
		return list;
	}

	/**
	 * 功能：
	 * @param roleId
	 * @param menus
	 */
	public void saveRoleMenu(String roleId, String[] menus) {
		roleDao.deleteRoleMenu(roleId);
		if(menus != null){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("roleId", roleId);
			for(String menuId : menus){
				map.put("menuId", menuId);
				roleDao.insertRoleMenu(map);
			}
		}
		
	}

	/**
	 * 功能：
	 * @param data
	 */
	public void save(Map<String, Object> data) {
		if(StringUtil.isEmpty((String) data.get("ID"))){
			roleDao.insert(data);
		}else{
			roleDao.update(data);
		}
	}

	/**
	 * 功能：
	 * @param roleId
	 * @return
	 */
	public Map<String, Object> getRoleById(String roleId) {
		return roleDao.getRoleById(roleId);
	}

	/**
	 * 功能：获取角色菜单编辑树
	 * @param roleId
	 * @return
	 */
	public List<Map<String, Object>> getRoleMenuEditTree(String roleId) {
		return roleDao.getRoleMenuEditTree(roleId);
	}

	public List<Map> getRoles() {
		return roleDao.getRoles();
	}
}
