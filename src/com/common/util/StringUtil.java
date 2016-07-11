/**
 * 
 */
package com.common.util;

public class StringUtil {

	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0 || "_empty".equals(str);
	}


}
