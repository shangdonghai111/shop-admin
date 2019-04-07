package com.fh.shop.backend.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class BaseController {
	/**
	 * <pre>ajaxOut(将json格式的字符串转换为javabean)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2018年12月27日 上午8:50:41    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2018年12月27日 上午8:50:41    
	 * 修改备注： 
	 * @param json
	 * @param response</pre>
	 */
	public void ajaxOut(String json,HttpServletResponse response){
		PrintWriter writer=null;
		try {
			writer= response.getWriter();
			writer.write(json);
			writer.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(null!=writer){
				writer.close();
				writer=null;
			}
		}
	}
	/**
	 * <pre>outJson(将json格式的字符串转换为javabean)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月9日 下午2:29:36    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月9日 下午2:29:36    
	 * 修改备注： 
	 * @param json
	 * @param response</pre>
	 */
	public void outJson(String json,HttpServletResponse response){
		PrintWriter writer=null;
		try {
		//设置响应内容的类型，并设置编码格式
			response.setContentType("application/json;charset=utf-8");
			writer= response.getWriter();
			writer.write(json);
			writer.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(null!=writer){
				writer.close();
				writer=null;
			}
		}
	}


}
