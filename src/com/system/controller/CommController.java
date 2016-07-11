package com.system.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/comm")
public class CommController {
	@RequestMapping("/downloadImportModel")
	public void downloadImportModel(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String filePath = request.getSession().getServletContext().getInitParameter("importModel");
		String rootPath= request.getSession().getServletContext().getRealPath("/");    
		filePath = rootPath + filePath;
		
		InputStream inStream=null;
		
		String name = URLDecoder.decode(request.getParameter("fileName"), "UTF-8");;
		try {
			
			inStream = new FileInputStream(filePath +"\\" + name);
			//解决中文文件名乱码问题
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
				name = URLEncoder.encode(name, "UTF-8");  
			} else {  
				name = new String(name.getBytes("UTF-8"), "ISO8859-1");  
			}  
			response.reset();// 清空输出流   
			response.setHeader("Content-disposition", "attachment; filename="+name);// 设定输出文件头   
			response.setContentType("application/msexcel");// 定义输出类型 
			
			// 循环取出流中的数据
			byte[] b = new byte[100];
			int len;
			
			while ((len = inStream.read(b)) > 0)
				response.getOutputStream().write(b, 0, len);
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				if(inStream!=null)
					inStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
