package com.common.listener;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.system.service.StandardsService;

public class InitListener implements ServletContextListener {
	
	public final static String STD_LIST = "STD_LIST";
	public final static String STD_MAP = "STD_MAP";
	public final static String STD_MAP_turn = "STD_MAP_turn";

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		 //spring 上下文
	    ApplicationContext	 appContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
	    StandardsService standardsService = (StandardsService) appContext.getBean("standardsService");
	    //获取代码信息
	    Map<String, List<Map>> stdList = standardsService.getInitStandards();
	    Map<String, Map> stdMap = standardsService.changeToMap(stdList);
	    Map<String, Map> stdMap_turn = standardsService.changeToMap_turn(stdList);
	    sce.getServletContext().setAttribute(STD_LIST, stdList);
	    sce.getServletContext().setAttribute(STD_MAP, stdMap);
	    sce.getServletContext().setAttribute(STD_MAP_turn, stdMap_turn);
	    //获取版本信息
	    //Map<String, Map> sysVersion = codeService.getCurrentVersion();
	    //sce.getServletContext().setAttribute("sysVersion", sysVersion);
		
	}

}
