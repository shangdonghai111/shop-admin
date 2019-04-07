package com.fh.shop.backend.common;

public enum ResponseEnum {
	//把枚举的类当作一个对象  下面的就是定义的方法 里面是传递的参数
	USER_LOCKERROR(105,"账号锁定"),
	IMAGECODE_ERROR(104,"验证码错误"),
	USERPWD_ERROR(103,"密码错误"),
	USERNAME_ERROR(102,"用户名不存在"),
	USERNAME_USERPWD_EMPTY(101,"用户名.密码或者验证码为空"),
	ERROR(-1,"系统异常"),
	SUCCESS(200,"登录成功");
	
	private int code;
	private String msg;
	public int getCode() {
		return code;
	}
	public String getMsg() {
		return msg;
	}
	private ResponseEnum(int code,String msg){
		this.code=code;
		this.msg=msg;
	}
}




















