/**
 * 
 */
package com.common.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

/**
 * @author 陈家桂
 * 
 */
public class DateUtil {

	/**
	 * 检验输入是否为正确的日期格式,默认格式:yyyy-MM-dd
	 * 
	 * @param sourceDate
	 * @return
	 */
	public static boolean isDefaultDateStringValid(String dateStr) {
		return DateUtil.isDateStringValid(dateStr, "yyyy-MM-dd");
	}

	/**
	 * 功能：检验输入是否为正确的日期格式
	 * 
	 * @param dateStr
	 * @param format
	 * @return
	 */
	private static boolean isDateStringValid(String dateStr, String format) {
		if (!StringUtils.isNotEmpty(dateStr))
			return true;
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat(format);
			dateFormat.setLenient(false);
			dateFormat.parse(dateStr);
			return true;
		} catch (Exception e) {
			return false;
		}

	}

	/**
	 * 将日期字符串转化为日期。失败返回null。
	 * 
	 * @param date
	 *            日期字符串
	 * @param parttern
	 *            日期格式
	 * @return 日期
	 */
	public static java.sql.Date StringToSqlDate(String dateStr, String parttern) {
		if (dateStr != null) {
			try {
				Date date = new SimpleDateFormat(parttern).parse(dateStr);
				return new java.sql.Date(date.getTime());
			} catch (Exception e) {
			}
		}
		return null;
	}

	/**
	 * 功能：获取当前年度
	 * @return
	 */
	public static String getThisYear() {
		Date date = new Date();
		return new SimpleDateFormat("yyyy").format(date);
	}

	/**
	 * 功能：
	 * @return
	 */
	public static List<String> getYearSelect() {
		List<String> years = new ArrayList<String>();
		int year = new Date().getYear() + 1900;
		for(int i=0; i<10; i++){
			years.add(String.valueOf(year - i));
		}
		return years;
	}
	public static List<Map> getYearSelectMap() {
		List<Map> years = new ArrayList<Map>();
		int year = new Date().getYear() + 1900;
		for(int i=0; i<10; i++){
			Map map = new HashMap(2);
			map.put("VALUE", String.valueOf(year - i));
			map.put("TEXT", String.valueOf(year - i));
			years.add(map);
		}
		return years;
	}

	/**
	 * 功能：
	 * @return
	 */
	public static String LastYear() {
		int lastYear =  Integer.parseInt(getThisYear()) - 1;
		return String.valueOf(lastYear);
	}
	/**
	 * 功能：
	 * @return
	 */
	public static Object fmtDate(Object data) {
		if(data == null) return null;
		if(data instanceof Map){
			Map map  = ((Map)data);
			Iterator entries = map.entrySet().iterator();
		    Map.Entry entry;
		    while (entries.hasNext()) {
		        entry = (Map.Entry) entries.next();
		        String name = (String) entry.getKey();
		        Object valueObj = entry.getValue();
		        if(valueObj == null) continue;
		        if(valueObj instanceof Timestamp){
		        	valueObj = new SimpleDateFormat("yyyy-MM-dd").format(((Timestamp)valueObj).getTime());
		        	map.put(name, valueObj);
		        }if(valueObj instanceof Map){
		        	fmtDate(valueObj);
		        }else if(valueObj.getClass().isArray() || valueObj instanceof List){
		        	fmtDate(valueObj);
		        }
		    }  
		}else if(data.getClass().isArray()){
			for(Object o : (Object[])data){
				fmtDate(o);
			}
		}else if(data instanceof List){
			List list = (List)data;
			for(Object o : list){
				fmtDate(o);
			}
		}
		return data;
	}

	/**
	 * 功能：
	 * @return
	 */
	public static int getThisMonth() {
		Calendar calendar=Calendar.getInstance();
		return calendar.get(Calendar.MONTH)+1;
	}
	
	

}
