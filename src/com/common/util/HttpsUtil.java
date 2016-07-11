package com.common.util;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.GetMethod;

public class HttpsUtil {

	public static String doGet(String url) throws HttpException, IOException {
		HttpClient httpclient = new HttpClient();
		GetMethod httpget = new GetMethod(url);
		try { 
		    httpclient.executeMethod(httpget);
		    return httpget.getResponseBodyAsString();
		} finally {
		    httpget.releaseConnection();
		}
	}
	

}
