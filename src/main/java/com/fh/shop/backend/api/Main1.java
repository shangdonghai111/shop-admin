package com.fh.shop.backend.api;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

public class Main1 {
    public static void main(String[] args) {
        //打开浏览器
        CloseableHttpClient client = HttpClientBuilder.create().build();
        //输入网址
        HttpGet httpGet = new HttpGet("https://www.baidu.com/index.php?tn=93274208_hao_pg");
        CloseableHttpResponse response=null;
        try {
            //发送请求
             response = client.execute(httpGet);
             //设置响应内容并指定编码格式
            HttpEntity entity = response.getEntity();

            String s = EntityUtils.toString(entity, "utf-8");
            //输出
            System.out.println(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            //关流
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
            if (client!=null){
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
