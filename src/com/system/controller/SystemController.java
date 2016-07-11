/**
 * 
 */
package com.system.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.common.util.Ajax;
import com.common.util.AjaxUtil;

/**
 * @author 闄堝妗�
 *
 */
@Controller
public class SystemController {
	
	@RequestMapping("/index")
	public String index() {
		return "/index";
	}
	@RequestMapping("/main")
	public String main() {
		return "/main";
	}
	@RequestMapping("/login")
	public String login() {
		return "/login";
	}
	
	@RequestMapping("/getStdJson")
	public void getAllDic(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Map> stdList = (Map<String, Map>) request.getSession().getServletContext().getAttribute("STD_MAP");
		Ajax.returnData(stdList, response);
	}
}
