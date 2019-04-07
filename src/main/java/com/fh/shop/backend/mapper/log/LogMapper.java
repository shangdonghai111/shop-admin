package com.fh.shop.backend.mapper.log;

import com.alibaba.dubbo.common.utils.Log;
import com.fh.shop.backend.po.log.LogInfo;

import java.util.List;

public interface LogMapper {

	void add(LogInfo log);

    Long findLogListCount(LogInfo logInfo);

    List<LogInfo> queryLogList(LogInfo logInfo);

    void deleteAllLog(List list);
}
