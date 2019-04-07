package com.fh.shop.backend.common;

import javax.servlet.http.HttpServletRequest;

public class WebContent {
	private static ThreadLocal<HttpServletRequest> requestContent=new ThreadLocal<>();
	//往Threadlocal中存值 以当前请求所对应的线程作为key 以request作为value存值
	public static void setRequest(HttpServletRequest request){
		requestContent.set(request);
	}
	//取值 以当前请求所对应的线程作为key 获取该key所对应的value 即request
	public static HttpServletRequest getRequest(){
		return requestContent.get();
		
	}
	//移除值 从threadLocal中删除当前key对应的request；解除request和当前线程的绑定
	public static void remove(){
		requestContent.remove();
	}
}
