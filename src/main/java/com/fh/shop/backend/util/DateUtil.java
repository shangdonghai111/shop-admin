package com.fh.shop.backend.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    public static final String FULL_DATE="yyyy-MM-dd HH:mm:ss";
    public static final String Y_M_D="yyyy-MM-dd";

/**
* @Description:    日期类型转换为字符串
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/2/23 13:35
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/2/23 13:35
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
public static String date2Str(Date date,String pattern){
    if (date==null){
        return "";
    }
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    String result = simpleDateFormat.format(date);
    return result;
}
/**
* @Description:    字符串转换为时间类型
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/2/23 13:35
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/2/23 13:35
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
public static Date str2Date(String dataStr,String pattern){
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    Date result=null;
    try {
         result = simpleDateFormat.parse(dataStr);
    } catch (ParseException e) {
        e.printStackTrace();
    }
    return result;
}

}
