package com.fh.shop.backend.biz.log;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.dubbo.common.utils.Log;
import com.fh.shop.backend.mapper.log.LogMapper;
import com.fh.shop.backend.po.log.LogInfo;

import java.util.ArrayList;
import java.util.List;

@Service
public class LogServiceImpl implements LogService {
	@Resource
	private LogMapper logMapper;

	@Override
	public void add(LogInfo log) {
		logMapper.add(log);
		
	}

	@Override
	public Long findLogListCount(LogInfo logInfo) {
		return logMapper.findLogListCount(logInfo);
	}

	@Override
    public List<LogInfo> queryLogList(LogInfo logInfo) {
        return logMapper.queryLogList(logInfo);
    }

    @Override
    public void deleteAllLog(String ids) {
		String[] split = ids.split(",");
		List list = new ArrayList();
		for (int i=0;i<split.length;i++){
		    list.add(split[i]);
        }
		logMapper.deleteAllLog(list);
	}
}
