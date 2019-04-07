package com.fh.shop.backend.interceptor;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fh.shop.backend.gloable.Gloable;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LogInterceptor extends HandlerInterceptorAdapter{
	//重写preHandle方法
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		 String servletPath = request.getServletPath();
		String requestURI = request.getRequestURI();
		StringBuffer requestURL = request.getRequestURL();
		System.out.println(servletPath+":"+requestURI+":"+requestURL);
		String[] strings = Gloable.NO_PRODUCT.split(",");
		for (String string : strings) {
			//判断地址以login.jhtml结尾 放行
			if(requestURI.endsWith(string)){
				return true;
			}
		}

		
		Object userInfo = request.getSession().getAttribute(Gloable.USER_SESSION);
		//判断从session中获取的从登录中获取的数据库里面的值 
		if(userInfo!=null){
			return true;
		}else{
			//重定向到登录页面
			response.sendRedirect(Gloable.LOGIN_JSP);
		return false;
		}
	}
}
