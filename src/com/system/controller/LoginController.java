package com.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.util.Ajax;
import com.common.util.ReqUtil;
import com.common.util.SessionUtil;
import com.system.model.SessionUser;
import com.system.service.UserService;

@Controller
@RequestMapping("/login")
public class LoginController {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/doLogin")
	public String doLogin(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> data = ReqUtil.getParameterMap(request);
//		String checkcode=(String)request.getSession().getAttribute("checkcode");
//		String randomCode=(String)data.get("randomCode");
//		boolean isEqual=randomCode.equalsIgnoreCase(checkcode);//忽略大小写
//		if(isEqual){
			if(data.get("ACCOUNT") != null){
				SessionUser user=userService.getUserByAccountPs(data);
				if(user != null){
					SessionUtil.setUserSession(request, user);
					Ajax.returnData("success", response);
				}else{
					Ajax.returnData("AccountOrPsError", response);
				}
				return null;
			}else{
				return "redirect:/login";
			}
//		}else{			
//			Ajax.returnData("CheckCodeError", response);
//			return null;
//		}		
	}
	
	@RequestMapping("/quit")
	public String quit(HttpServletRequest request, HttpServletResponse response){
		if(SessionUtil.getUserSession(request) != null){
			SessionUtil.removeUserSession(request);
			Ajax.returnSuccess(response);
			return null;
		}else{
			return "redirect:/login";
		}		
	}	
	
}
