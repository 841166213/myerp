package com.common.util;

import javax.servlet.http.HttpServletRequest;

import com.system.model.SessionUser;

public class SessionUtil {
	public static final String session_user_key = "erp_session_user";

	public static void setUserSession(HttpServletRequest request,
			SessionUser user) {
		request.getSession().setAttribute(session_user_key, user);
	}

	public static void removeUserSession(HttpServletRequest request) {
		request.getSession().removeAttribute(session_user_key);
	}

	public static SessionUser getUserSession(HttpServletRequest request) {
		return  (SessionUser) request.getSession().getAttribute(session_user_key);
	}
}
