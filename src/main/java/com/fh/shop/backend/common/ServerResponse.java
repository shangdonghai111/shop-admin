package com.fh.shop.backend.common;

import java.io.Serializable;

public class ServerResponse implements Serializable{
	private static final long serialVersionUID = -4291247662308738898L;
	private int code;
	private String msg;
	private Object data;
	//无参有参构造   存在就只用生成get
	private ServerResponse(){
		
	}
	private ServerResponse(int code,String msg,Object data){
		this.code=code;
		this.msg=msg;
		this.data=data;
	}
	//定义方法
	public static ServerResponse success(){
		return new ServerResponse(ResponseEnum.SUCCESS.getCode(), ResponseEnum.SUCCESS.getMsg(), null);
		
	}
	public static ServerResponse success(Object data){
		return new ServerResponse(ResponseEnum.SUCCESS.getCode(), ResponseEnum.SUCCESS.getMsg(), data);
	}
	public static ServerResponse error(){
		return new ServerResponse(ResponseEnum.ERROR.getCode(),ResponseEnum.ERROR.getMsg(), null);
	}
	public static ServerResponse error(ResponseEnum responseEnum){
		return new ServerResponse(responseEnum.getCode(), responseEnum.getMsg(), null);
	}
	
	public static ServerResponse error(int code,String msg){
		return new ServerResponse(code, msg, null);
		
	}
	
	public int getCode() {
		return code;
	}
	
	public String getMsg() {
		return msg;
	}
	
	public Object getData() {
		return data;
	}

	
}
