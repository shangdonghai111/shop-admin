package com.fh.shop.backend.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisPool {
    //单例和Jedis连接池结合 保证有且只有一个连接池
    private static JedisPool jedisPool;

    private static void initPool(){
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxTotal(1000);//创建了连接池并设置最大连接数
        jedisPoolConfig.setMaxIdle(10);
        jedisPoolConfig.setMinIdle(10);
        jedisPoolConfig.setTestOnBorrow(true);
        jedisPoolConfig.setTestOnReturn(true);
        //连接池   虚拟机的ip地址  设置的redis端口号
        jedisPool = new JedisPool(jedisPoolConfig, "192.168.1.111", 7020);
    }
        static{
        initPool();//加载初始化initPool()的时候就构建了一个连接池
        }
        //无参构造
    private RedisPool(){ }

    //获取连接池里面的资源,通过Jedis返回
    //外部调用的是getResources()方法
    public static Jedis getResources(){
     return jedisPool.getResource();//返回值类型Jedis
    }

    public static void main(String[] args) {
        Jedis jedis=getResources();
        jedis.set("username","张三");
    }
}
