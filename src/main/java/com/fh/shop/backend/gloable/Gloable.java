package com.fh.shop.backend.gloable;

import java.util.HashMap;
import java.util.Map;

public final class Gloable {
    //定义状态
    public static final int SYSTEM_SUCCESS=1;
    public static final int SYSTEM_ERROR=0;
    //定义错误时间
    public static final int SYSTEM_ERROR_TIME=-1;

    public static final String SYSTEM_IMAGESPATH="/images/";

    public static final String SYSTEM_IMAGECODE="code";

    public static final int ERROR_COUNT=3;

    public static final int ERROR_STATUS=1;

    public static final String USER_SESSION="user";

    public static final String LOGIN_JSP="/login.jsp";

    public static final String NO_PRODUCT="/user/login.jhtml,/user/toAdd.jhtml,/api/queryProductApi.jhtml,/brand/queryBrandApi.jhtml";

    public static final String ORDER_MAPPING="{productPrice:price,entrtyTime:entrtyDate,updateTime:updateDate}";

    public static final String ORDER_COLUMN= "order[0][column]";
    public static final String ORDER_DIR= "order[0][dir]";

    public static final String COS_ACCESSKEY="AKIDPq44pMdjwviIcibCcrreDXeW9ZliRhLA";
    public static final String COS_SECERTKEY="kKFwRxIOFPL7e1JTP5btwjJo57uZ0C9s";
    public static final String COS_AREA="ap-beijing";
    public static final String COS_BUCKETNAME="fh-1808-1258899193";
    public static final String COS_URL="\thttps://fh-1808-1258899193.cos.ap-beijing.myqcloud.com/";

    //静态的常量   没有final是静态变量
    public static final Map  FIELD_MAPPING=new HashMap();
    //定义静态块  注意静态块只能调用静态方法
    static {
       /* FIELD_MAPPING.put("productPrice","price");
        FIELD_MAPPING.put("entrtyTime","entrtyDate");
        FIELD_MAPPING.put("updateTime","updateDate");*/
    }

}
