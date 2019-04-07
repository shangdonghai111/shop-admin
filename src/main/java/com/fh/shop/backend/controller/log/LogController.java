package com.fh.shop.backend.controller.log;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.fh.shop.backend.common.ServerResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fh.shop.backend.biz.log.LogService;
import com.fh.shop.backend.po.log.LogInfo;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("log")
public class LogController {
	@Resource
	private LogService logService;
	/**
	 * <pre>add(日志增加)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月10日 下午9:26:51    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月10日 下午9:26:51    
	 * 修改备注： 
	 * @param log
	 * @return</pre>
	 */
	@RequestMapping("add")
	public String add(LogInfo log){
		logService.add(log);
		return null;
	}
	/**
	* @Description:    日志分页查询
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/3/1 16:29
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/3/1 16:29
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("queryLogList")
	@ResponseBody
	public Map queryUserList(Integer draw, Integer start, Integer length, LogInfo logInfo){

		//给开始条数和每页条数赋值
		logInfo.setStartPos(start);
		logInfo.setPageSize(length);



		// 获取总条数
		Long totalCount=logService.findLogListCount(logInfo);
		// 获取分页列表
		List<LogInfo> list=logService.queryLogList(logInfo);
		HashMap hashMap = new HashMap();
		hashMap.put("draw",draw);
		hashMap.put("recordsTotal",totalCount);
		hashMap.put("recordsFiltered",totalCount);
		hashMap.put("data",list);
		return hashMap;

	}
	/**
	* @Description:    跳转至日志分页查询
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/3/2 15:19
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/3/2 15:19
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("toQueryLogList")
	public String toQueryLogList(){
	    return "log/logList";
    }
    /**
    * @Description:    批量删除
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/2 15:39
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/2 15:39
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("deleteAllLog")
	@ResponseBody
    public ServerResponse deleteAllLog(String ids, HttpServletResponse response){
        logService.deleteAllLog(ids);
		return ServerResponse.success();
    }
}
