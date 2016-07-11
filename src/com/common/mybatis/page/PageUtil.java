package com.common.mybatis.page;

import javax.servlet.http.HttpServletRequest;

public class PageUtil {
	private static final int CURRENT_PAGE = 1;
	private static final int PAGE_SIZE = 15;
	
	public static int getCurrentPage(HttpServletRequest request) {
		int currentPage = CURRENT_PAGE;
		try{
			if (request.getParameter("page") != null) {
				currentPage = Integer.parseInt(request.getParameter("page"));
			}
		}catch(Exception e){
			return CURRENT_PAGE;
		}
		return currentPage < 1 ? 1 : currentPage;
	}
	
	public static int getPageSize(HttpServletRequest request) {
		int pageSize = PAGE_SIZE;
		try{
			if (request.getParameter("rows") != null) {
				pageSize = Integer.parseInt(request.getParameter("rows"));
			}
		}catch(Exception e){
			return PAGE_SIZE;
		}
		return pageSize;
	}

}
