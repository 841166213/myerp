package com.common.mybatis.page;


import java.util.List;

public class Page<T> {
	/**
     * 总行数
     */
    private int records;

    /**  
     * 每页行数
     */
    private int rows;

    /**  
     * 当前页码
     */
    private int page;

    /**  
     * 总页数
     */
    private int total;


    /**  
     * 分页数据
     */
    private List<T> list;

    public Page(int records, int currentCount) {
        this.records = records;
        this.page = currentCount;
        this.rows = 10;
        calculate();
        
        if (records == 0) {
            this.page = 0;
        }
    }
    
    public Page(int records, int page, int rows) {
        this.records = records;
        this.page = page;
        this.rows = rows;
        calculate();

        if (records == 0) {
            this.page = 0;
        }
    }

	public Page(int records, List<T> list, int page,
			int rows) {
		this(records, page, rows);
		this.list = list;
	}

	private void calculate() {
        total = records / rows + ((records % rows) > 0 ? 1 : 0);

        if (page > total) {
            page = total;
        }
        else if (page < 1) {
            page = 1;
        }

    }

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}


}
