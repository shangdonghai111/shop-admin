package com.fh.shop.backend.logAspect;


import java.lang.reflect.Method;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.gloable.Gloable;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.condition.RequestConditionHolder;

import com.fh.shop.backend.biz.log.LogService;
import com.fh.shop.backend.common.WebContent;
import com.fh.shop.backend.controller.BaseController;
import com.fh.shop.backend.po.log.LogInfo;
import com.fh.shop.backend.po.user.User;

public class LogAspect{
	private static final Logger LOG=LoggerFactory.getLogger(LogAspect.class);
	@Resource
	private LogService logService;
	//获取session的两种方式 第一种
	@Autowired
	HttpServletRequest request;
	public Object logAspect(ProceedingJoinPoint pjp){
		LogInfo logInfo=new LogInfo();
		//获取session的两种方式 第二种
		HttpServletRequest request2 = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		//获取类的全称
		String className = pjp.getTarget().getClass().getCanonicalName();
		//获取方法名
		String methodName = pjp.getSignature().getName();
		//LOG.info("进入{}的{}()",className,methodName);
		//动态获取方法签名
		MethodSignature ms =(MethodSignature)pjp.getSignature();
		//获取方法名
		Method method = ms.getMethod();
		String value="";
		//判断类中方法上是否有自定义注解
		if(method.isAnnotationPresent(LogAnnotation.class)){
			//获取类里面自定义注解
			LogAnnotation logAnnotation = method.getAnnotation(LogAnnotation.class);
			//获取内容
			value = logAnnotation.value();
		}
		Object proceed=null;
		try {
			long startTime=System.currentTimeMillis();
			//执行业务逻辑
			 proceed = pjp.proceed();
			//获取用户信息  login方法执行之后才会将用户信息存放到session中
			User userInfo = (User) WebContent.getRequest().getSession().getAttribute("user");
				//System.out.println(userInfo.getUserName()+"-------");
			 User user = (User) request2.getSession().getAttribute("user");
			 if (user!=null){
				 long endTime=System.currentTimeMillis();
				 logInfo.setUserName(userInfo.getUserName());
				 logInfo.setOperate("执行"+className+";"+methodName+"方法成功");
				 logInfo.setIpAdress(getIpAddress());
				 logInfo.setOperateTime(new Date());
				 logInfo.setExecuteTime((long)(endTime-startTime));
				 logInfo.setStatus(Gloable.SYSTEM_SUCCESS);
				 logInfo.setContent(value);
				 logService.add(logInfo);
				 LOG.info("{}执行{}的{}()成功",userInfo.getUserName(),className,methodName);
			 }

		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//获取用户信息  login方法执行之后才会将用户信息存放到session中
			User userInfo = (User) WebContent.getRequest().getSession().getAttribute("user");
			logInfo.setUserName(userInfo.getUserName());
			logInfo.setOperate("执行"+className+";"+methodName+"方法失败");
			logInfo.setIpAdress(getIpAddress());
			logInfo.setOperateTime(new Date());
			logInfo.setExecuteTime(Gloable.SYSTEM_ERROR_TIME);
			logInfo.setStatus(Gloable.SYSTEM_ERROR);
			logInfo.setContent(value);
			logService.add(logInfo);
			LOG.error("{}执行{}的{}()失败:{}",userInfo.getUserName(),className,methodName,e.getMessage());
		}
		return proceed;
	}
	/**
	 * <pre>getIpAddress(获取ip地址)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月22日 下午3:07:46    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月22日 下午3:07:46    
	 * 修改备注： 
	 * @return</pre>
	 */
	public  String getIpAddress() {  
		
        String ip = request.getHeader("x-forwarded-for");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;  
	}
}
