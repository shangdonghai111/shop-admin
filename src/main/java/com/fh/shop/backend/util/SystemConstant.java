package com.fh.shop.backend.util;

import java.util.HashMap;
import java.util.Map;

public final class SystemConstant {
    public static final Integer STATUS_SUCCESS = 1;
    public static final Integer STATUS_ERROR = 0;
    public static final Integer EXECUTE_TIME_ERROR = -1;
    public static final String PRODUCT_IMAGE_PATH ="/images/";
    public static final String IMGCODE = "code";
    //登陆拦截器的白名单
    public static final String WHITE_LIST = "/user/login.jhtml,/user/toAddUser.jhtml," +
            "/user/addUser.jhtml,/api/product/queryProductListApi.jhtml,/api/brand/queryBrandListApi.jhtml";
    //用户锁定状态
    public static final Integer USER_LOCK_STATUS = 0;
    //用户锁定的错误登陆次数3
    public static final Integer LOCK_ERROR_COUNT = 3;
    //登陆成功存进session的用户信息
    public static final String USER_SESSION = "userDB";
    //排序的映射
    public static final Map<String,String> ORDER_MAP  = new HashMap();
    //静态块
    static{
        ORDER_MAP.put("entryTimeStr", "entryTime");
        ORDER_MAP.put("updateTimeStr", "updateTime");
    }
    //排序的映射
    public static final String ORDER_MAP_STR = "{'entryTimeStr':'entryTime','updateTimeStr':'updateTime'}";
    //排序的列号
    public static final String ORDER = "order[0][column]";
    //排序的字段
    public static final String ORDER_DIR = "order[0][dir]";

}
