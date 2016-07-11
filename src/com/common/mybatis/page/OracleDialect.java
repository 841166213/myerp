package com.common.mybatis.page;

public class OracleDialect extends Dialect{

	@Override
	public String getLimitString(String sql, int offset, int limit) {

		sql = sql.trim();
		
		StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);
		
		pagingSelect.append("select * from ( select row_.*, rownum rno from ( ");
		
		pagingSelect.append(sql);
		
		pagingSelect.append(" ) row_ ) where rno > ").append((offset-1)*limit).append(" and rno <= ").append(offset * limit);
		
		return pagingSelect.toString();
	}

}
