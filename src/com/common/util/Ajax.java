package com.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.common.mybatis.page.Page;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Ajax {
	public static void returnSuccess(HttpServletResponse response) {
		Result result = new Result("success");
		returnJsonObject(result, response);
	}
	public static void returnFail(HttpServletResponse response) {
		Result result = new Result("fail");
		returnJsonObject(result, response);
	}
	public static void returnFail(String message, HttpServletResponse response) {
		Result result = new Result("fail", message);
		returnJsonObject(result, response);
	}
	
	public static void returnData(Object data, HttpServletResponse response) {
		Result result = new Result("success", data);
		returnJsonObject(result, response);
	}
	public static void returnPage(Page<Map<String, Object>> page, HttpServletResponse response) {
		returnJsonObject(page, response);
	}
	private static void returnJsonObject(Object data,
			HttpServletResponse response) {
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		String json = gson.toJson(data);
		//生成返回的XML文件
		try {
			out = response.getWriter();
			out.print(json);
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}
	public static void printJsonString(String string, HttpServletResponse response) {
		response.setContentType("text/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		response.setHeader("Cache-Control", "no-cache");
		
		PrintWriter out=null;
		try {
			out = response.getWriter();
			
			out.print(string.replace("'", "\""));
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}

}
