/**
 * 
 */
package com.common.util;

import java.io.File;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

/**
 * @author 陈家桂
 * 
 */
public class ExcelUtil {

	/**
	 * 功能：获取cell内容，防止数组溢出
	 * 
	 * @param cells
	 * @param i
	 * @return
	 */
	public static String getCellContent(Cell[] cells, int i) {
		int size = cells.length;
		return i > size - 1 ? "" : cells[i].getContents();
	}

	/**
	 * 导出Excel
	 * 
	 * @param list
	 *            ：结果集合
	 * @param filePath
	 *            ：指定的路径名
	 * @param response.getOutputStream()
	 *            ：输出流对象 通过response.getOutputStream()传入
	 * @param headers
	 *            ：表头信息
	 * @param keySet
	 *            ：表头对应的数据字段
	 * @param sheetName
	 *            ：工作表名称
	 */
	public static void createExcel(List list, Class listClass, String filePath,
			HttpServletResponse response, String headers[], String keySet[], String sheetName) {
		sheetName = sheetName != null && !sheetName.equals("") ? sheetName
				: "sheet1";
		WritableWorkbook wook = null;// 可写的工作薄对象
		try {
			if (filePath != null && !filePath.equals("")) {
				wook = Workbook.createWorkbook(new File(filePath));// 指定导出的目录和文件名
				// 如：D:\\test.xls
			} else {
				response.setContentType("application/x-download");
				String fileName = sheetName + ".xls";
				//设置下载文件名
				response.addHeader("Content-Disposition", "attachment;filename="+
						new String(fileName.getBytes("gb2312"),"iso8859-1"));
				wook = Workbook.createWorkbook(response.getOutputStream());// jsp页面导出用
			}

			// 设置头部字体格式
			WritableFont font = new WritableFont(WritableFont.TIMES, 10,
					WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,
					Colour.RED);
			// 应用字体
			WritableCellFormat wcfh = new WritableCellFormat(font);
			// 设置其他样式
			wcfh.setAlignment(Alignment.CENTRE);// 水平对齐
			wcfh.setVerticalAlignment(VerticalAlignment.CENTRE);// 垂直对齐
			wcfh.setBorder(Border.ALL, BorderLineStyle.THIN);// 边框
			wcfh.setBackground(Colour.YELLOW);// 背景色
			wcfh.setWrap(false);// 不自动换行

			// 应用日期格式
			WritableCellFormat wcfc = new WritableCellFormat();

			wcfc.setAlignment(Alignment.CENTRE);
			wcfc.setVerticalAlignment(VerticalAlignment.CENTRE);// 垂直对齐
			wcfc.setBorder(Border.ALL, BorderLineStyle.THIN);// 边框
			wcfc.setWrap(false);// 不自动换行

			// 创建工作表
			WritableSheet sheet = wook.createSheet(sheetName, 0);
			SheetSettings setting = sheet.getSettings();
			setting.setVerticalFreeze(1);// 冻结窗口头部

			if (headers != null && keySet != null && headers.length == keySet.length) {
				String key = "";
				// 开始导出表格头部
				for (int i = 0; i < headers.length; i++) {
					// 应用wcfh样式创建单元格
					sheet.addCell(new Label(i, 0, headers[i],
							wcfh));
				}
				
				if (list != null && list.size() > 0) {
					
					// 导出表格内容
					if(listClass == Map.class){
						for (int i = 0, len = list.size(); i < len; i++) {
							Map data = (Map) list.get(i);
							// 按保存的字段顺序导出内容
							for (int j = 0; j < keySet.length; j++) {
								if (data.get(keySet[j]) != null) {
									// 从对应的get方法得到返回值
									String value = data.get(keySet[j])
									.toString();
									// 应用wcfc样式创建单元格
									sheet.addCell(new Label(j, i + 1, value, wcfc));
								} else {
									// 如果没有对应的get方法，则默认将内容设为""
									sheet.addCell(new Label(j, i + 1, "", wcfc));
								}
								
							}
						}
					}else{
						Map<String, Method> getMap = getAllMethod(listClass);// 获得对象所有的get方法;
						Method method = null;
						Object objClass = null;
						for (int i = 0, len = list.size(); i < len; i++) {
							objClass = list.get(i);
							// 按保存的字段顺序导出内容
							for (int j = 0; j < keySet.length; j++) {
								// 根据key获取对应方法
								method = getMap.get("GET"
										+ keySet[j].toString()
										.toUpperCase());
								if (method != null) {
									// 从对应的get方法得到返回值
									String value = method.invoke(objClass, null) == null ? "" : String.valueOf(method.invoke(objClass, null));
									// 应用wcfc样式创建单元格
									sheet.addCell(new Label(j, i + 1, value, wcfc));
								} else {
									// 如果没有对应的get方法，则默认将内容设为""
									sheet.addCell(new Label(j, i + 1, "", wcfc));
								}
								
							}
						}
					}
				}
				wook.write();
				System.out.println("导出Excel成功！");
			} else {
				throw new Exception("传入参数不合法");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (wook != null) {
					wook.close();
				}
				if (response.getOutputStream() != null) {
					response.getOutputStream().close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	/**
	 * 获取类的所有get方法
	 * 
	 * @param cls
	 * @return
	 */
	public static HashMap<String, Method> getAllMethod(Class c)
			throws Exception {
		HashMap<String, Method> map = new HashMap<String, Method>();
		Method[] methods = c.getMethods();// 得到所有方法
		String methodName = "";
		for (int i = 0; i < methods.length; i++) {
			methodName = methods[i].getName().toUpperCase();// 方法名
			if (methodName.startsWith("GET")) {
				map.put(methodName, methods[i]);// 添加get方法至map中
			}
		}
		return map;
	}

	/**
	 * 根据指定路径导出Excel
	 * 
	 * @param list
	 * @param filePath
	 * @param headers
	 * @param keySet
	 * @param sheetName
	 */
	public static void exportLocalExcel(List list, Class listClass, String filePath,
			String headers[], String keySet[], String sheetName) {
		createExcel(list, listClass, filePath, null, headers, keySet, sheetName);
	}

	/**
	 * 从Jsp页面导出Excel
	 * 
	 * @param list
	 * @param filePath
	 * @param response
	 * @param headers
	 * @param keySet
	 * @param sheetName
	 */
	public static void exportJspExcel(List list, Class listClass, HttpServletResponse response,
			String headers[], String keySet[], String sheetName) {
		createExcel(list, listClass, null, response, headers, keySet, sheetName);
	}
}
