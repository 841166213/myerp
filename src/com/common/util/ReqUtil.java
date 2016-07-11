package com.common.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.system.model.SessionUser;

public class ReqUtil {
	/**
	 * 功能：获取查询参数封装于map中
	 * @param request
	 * @return
	 */
	public static Map<String, Object> getParameterMap(HttpServletRequest request) {
		// 参数Map
	    Map properties = request.getParameterMap();
	    // 返回值Map
	    Map<String, Object> returnMap = new HashMap<String, Object>();
	    Iterator entries = properties.entrySet().iterator();
	    Map.Entry entry;
	    while (entries.hasNext()) {
	        entry = (Map.Entry) entries.next();
	        String name = (String) entry.getKey();
	        Object valueObj = entry.getValue();
	        String value = "";
	        if(null == valueObj){
	            value = null;
	        }else if(valueObj instanceof String[]){
	        	String[] values = (String[])valueObj;
	        	for(int i=0;i<values.length;i++){
	        		value += values[i] + ",";
	        	}
	        	value = value.substring(0, value.length()-1);
	        	
	        	if(name.indexOf("[]") > 0){
	        		name = name.replace("[]", "");
	        		returnMap.put(name+"[]", valueObj);
	        	}else if(values.length > 1){
	        		returnMap.put(name+"[]", valueObj);
	        	}
	        	
	        }else{
	            value = valueObj.toString();
	        }
	        returnMap.put(name, value);
	    }
	    
	    SessionUser suser = SessionUtil.getUserSession(request);
	    if(suser != null){
	    	returnMap.put("suserId", suser.getId());
	    }
	    return returnMap;
	}
}
