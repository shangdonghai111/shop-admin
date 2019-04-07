package com.fh.shop.backend.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    public static void writeCookie(HttpServletResponse response,String key,String value,
                                   String domain,int maxAge){
        Cookie cookie = new Cookie(key,value);
        cookie.setDomain(domain);
        if (maxAge>-1){
            cookie.setMaxAge(maxAge);
        }
        cookie.setPath("/");
        response.addCookie(cookie);

    }

    public static void deleteCookie(HttpServletResponse response,String key,String value,
                                    String domain,int maxAge){

        writeCookie(response,key,"",domain,0);
    }

    public static String readCookie(HttpServletRequest request,String key){
        Cookie[] cookies = request.getCookies();
        if (null==cookies){
            return "";
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(key)){
                return cookie.getValue();
            }
        }
        return "";
    }



}
