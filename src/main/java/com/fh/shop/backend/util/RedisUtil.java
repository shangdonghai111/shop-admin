package com.fh.shop.backend.util;

import redis.clients.jedis.Jedis;

public class RedisUtil {
    public static void expire(String key,int seconds){
        Jedis jedis = null;//获取接点
        try {
            jedis = RedisPool.getResources();
            jedis.expire(key, seconds);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null!=jedis){
                jedis.close();
                jedis=null;
            }
        }
    }

    public static String get(String key){
        Jedis jedis = null;
        String result="";
        try {
            jedis = RedisPool.getResources();
             result = jedis.get(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null!=jedis){
                jedis.close();
                jedis=null;
            }
        }
        return result;
    }

    public static void set(String key,String value){
        Jedis jedis = null;//获取接点
        try {
            jedis = RedisPool.getResources();
            jedis.set(key, value);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null!=jedis){
                jedis.close();
                jedis=null;
            }
        }

    }

    public static void del (String key){
        Jedis jedis = null;//获取接点
        try {
            jedis = RedisPool.getResources();
            jedis.del(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null!=jedis){
                jedis.close();
                jedis=null;
            }
        }
    }
    public static void main(String[] args) {
        RedisUtil.set("bookname","三国");
        System.out.println(RedisUtil.get("bookname"));
    }
}
