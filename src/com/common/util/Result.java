package com.common.util;

public class Result {
	private String status;
	private Object data;
	private String message;
	
	public Result(String status) {
		super();
		this.status = status;
		this.message = status;
	}
	public Result(String status, String message) {
		super();
		this.status = status;
		this.message = message;
	}

	public Result(String status, Object data) {
		super();
		this.status = status;
		this.data = data;
		this.message = status;
	}
	
	public Result(String status, Object data, String message) {
		super();
		this.status = status;
		this.data = data;
		this.message = message;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
