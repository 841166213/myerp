package com.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.common.util.SessionUtil;
import com.system.model.SessionUser;

public class SessionFilter implements Filter {
	
	private final String[] NoFilter_Pages={"/login", "/js/", "/css/", "/images/", "/checkCode"};
	    
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		  
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
	
		// 从session里取的用户名信息
		SessionUser user = SessionUtil.getUserSession(req);//�����ȡsession��Ϊ�˼��session����û�б����û���Ϣ��û�еĻ���ת������½ҳ��
		// 获得用户请求的URI
		String path = req.getRequestURI();
		// 登陆页面和静态资源无需过滤
		for(String NoFilter_Page:NoFilter_Pages){
			if(path.indexOf(NoFilter_Page)>-1) {
				chain.doFilter(request,response);
				return;
			}
		}		
	  
		// 判断如果没有取到用户信息,就跳转到登陆页面
		if (user == null){
			//防止长时间未操作，连接超时，打开弹出层时只在弹出层跳转到登录页面
			String basePath = req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
			res.setContentType("text/html;charset=utf-8");
			res.getWriter().write(
	                "<script>window.top.location='"+basePath+"login';</script>");
			res.getWriter().flush();
		}else{
			// 已经登陆,继续此次请求
			chain.doFilter(request,response);
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}	

}
