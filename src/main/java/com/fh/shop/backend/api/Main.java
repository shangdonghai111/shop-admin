package com.fh.shop.backend.api;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class Main {
    public static void main(String[] args) {
       //打开浏览器
        CloseableHttpClient client = HttpClientBuilder.create().build();
        //输入网址
        HttpGet httpGet = new HttpGet("https://blog.csdn.net/nuaazhaofeng/article/details/63707235");
        CloseableHttpResponse response=null;
        try {
            //发送请求
             response = client.execute(httpGet);
             //获取响应并转编码格式
            HttpEntity entity = response.getEntity();
            String s = EntityUtils.toString(entity, "utf-8");
            //输出
            System.out.println(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            //关闭连接
            if (null!=response){
                try {
                    response.close();
                    response=null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null!=httpGet){
                httpGet.releaseConnection();
            }
            if (null!=client){
                try {
                    client.close();
                    client=null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
