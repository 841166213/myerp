/**
 * 
 */
package com.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author 陈家桂
 *
 */
public class AjaxUtil {
	/**
	 * 功能：
	 * @param string
	 * @param response
	 */
	public static void ajaxPrintString(String string, HttpServletResponse response) {
		response.setContentType("text/plain; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		//生成返回的XML文件
		try {
			out = response.getWriter();
			out.print(string);
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}
	
	/**
	 * 功能：
	 * @param data
	 * @param response
	 */
	public static void ajaxPrintJsonArray(List data,
			HttpServletResponse response) {
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		JSONArray jsonObject = JSONArray.fromObject(data);
		//生成返回的XML文件
		try {
			out = response.getWriter();
			out.print(jsonObject.toString());
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}
	/**
	 * 功能：
	 * @param data
	 * @param response
	 */
	public static void ajaxPrintJsonObject(Object data,
			HttpServletResponse response) {
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		JSONObject jsonObject = JSONObject.fromObject(data);
		//生成返回的XML文件
		try {
			out = response.getWriter();
			out.print(jsonObject.toString());
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}
	
	public static void ajaxPrintJsonString(String data,
			HttpServletResponse response) {
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		try {
			out = response.getWriter();
			
			out.print(data.replace("'", "\""));
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}

	/**
	 * 功能：操作成功
	 * @param response
	 */
	public static void ajaxPrintSuccess(HttpServletResponse response) {
		ajaxPrintString("success", response);
	}

}
