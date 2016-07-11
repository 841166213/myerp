/**
 * 
 */
package com.common.handler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

/**
 * @author 陈家桂
 * 
 */
public class WordModelHandler {
	private Configuration configuration = null;

	public WordModelHandler() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("UTF-8");
	}

	public void createDoc(String dir, String fileName, String savePath,
			Map<String, Object> dataMap) {
		// 设置模本装置方法和路径,FreeMarker支持多种模板装载方法。可以重servlet，classpath，数据库装载，
		Template t = null;
		try {
			// 从什么地方加载freemarker模板文件
			configuration.setDirectoryForTemplateLoading(new File(dir));

			// 设置对象包装器
			configuration.setObjectWrapper(new DefaultObjectWrapper());
			// 设置异常处理器
			configuration
					.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
			// 定义Template对象
			t = configuration.getTemplate(fileName);

		} catch (IOException e) {
			e.printStackTrace();
		}
		// 输出文档路径及名称
		File outFile = new File(savePath);
		Writer out = null;
		try {
			out = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(outFile), "utf-8"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		try {
			t.process(dataMap, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title", "题目");
		map.put("name", "姓名");
		WordModelHandler wh = new WordModelHandler();
		wh.createDoc("D:\\", "word测试.xml", "D:\\word测试结果.doc", map);
	}
}
