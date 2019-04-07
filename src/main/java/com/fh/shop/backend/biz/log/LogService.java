package com.fh.shop.backend.biz.log;

import com.alibaba.dubbo.common.utils.Log;
import com.fh.shop.backend.po.log.LogInfo;

import java.util.List;

public interface LogService {

	void add(LogInfo log);

    Long findLogListCount(LogInfo logInfo);

    List<LogInfo> queryLogList(LogInfo logInfo);

    void deleteAllLog(String ids);
}
