/**
 * 
 */
package com.common.mybatis.page;

/**
 * @author 陈家桂
 *
 */
public class MysqlDialect extends Dialect{

	@Override
	public String getLimitString(String sql, int offset, int limit) {

		sql = sql.trim();
		
		StringBuffer pagingSelect = new StringBuffer(sql);
		
		
		
		pagingSelect.append(" limit ").append((offset-1) * limit).append(", ").append(limit);
		
		return pagingSelect.toString();
	}
	
}
