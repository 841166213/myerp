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
import com.system.dao.MenuDao;
import com.system.dao.UserDao;
import com.system.model.Menu;
import com.system.model.SessionUser;

@Transactional(rollbackFor = Exception.class)
@Service("userService")
public class UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private MenuDao menuDao;

	public Page<Map<String, Object>> queryUserPage(Map<String, Object> query, int currentPage, int pageSize) {
		int totalRow = userDao.queryUserPageCount(query);
		List<Map<String, Object>> list = userDao.queryUserPage(query, new RowBounds(currentPage, pageSize));
		Page<Map<String, Object>> page = new Page<Map<String, Object>>(totalRow, list, currentPage, pageSize);
		return page;
	}

	public Map<String, Object> getUser(String id) {
		return userDao.getUser(id);
	}

	public void saveUser(Map<String, Object> data) {
		if(StringUtils.isNotBlank((String) data.get("ID"))){
			userDao.update(data);
		}else{
			userDao.insert(data);
		}
		
	}

	public void deleteUsers(String[] ids) {
		for(String id: ids){
			userDao.deleteUser(id);
		}
		
	}

	public List<Map> getUserRoles(String id) {
		return userDao.getUserRoles(id);
	}

	public void saveUserRole(String userId, String[] roleIds) {
		userDao.deleteUserRole(userId);
		if(roleIds != null){
			for(String roleId : roleIds){
				Map map = new HashMap(2);
				map.put("USER_ID", userId);
				map.put("ROLE_ID", roleId);
				userDao.insertUserRole(map);
			}
		}
		
	}

	public Map<String, Object> getUserByAccount(String account) {
		return userDao.getUserByAccount(account);
	}
	
	public SessionUser getUserByAccountPs(Map<String, Object> data){
		SessionUser user=userDao.getUserByAccountPs(data);
		if(user != null){
			List<Menu> Usermenus=new ArrayList<Menu>();//���ڴ���û���Ӧ�˵�����Ű���children��һ���˵���������û��Ĳ˵�Ȩ�ޣ�
			List<Menu> Rolesmenus=menuDao.getMenuByUserId(user.getId());//���ڴ���û����н�ɫ��Ӧ�˵����޳��ظ���
			
			//�������˵���������˵�children�������˵�����һ���˵�children
			for(Menu menu1:Rolesmenus){
				if(menu1.getType().equals("1")){
					List<Menu> children1=new ArrayList<Menu>();
					for(Menu menu2:Rolesmenus){
						if(menu2.getParentId() != null && menu1.getId().equals(menu2.getParentId())){
							List<Menu> children2=new ArrayList<Menu>();
							for(Menu menu3:Rolesmenus){
								if(menu3.getParentId() != null && menu2.getId().equals(menu3.getParentId())){
									children2.add(menu3);
								}
							}
							menu2.setChildren(children2);
							children1.add(menu2);
						}
					}
					menu1.setChildren(children1);
				}
			}
			//������children��һ���˵������û��˵�list
			for(Menu menu:Rolesmenus){
				if(menu.getType().equals("1")){
					Usermenus.add(menu);
				}				
			}

			//���û��˵�list����SessionUser��Menu
			user.setMenu(Usermenus);
		}
		
		return user;
	}
}
