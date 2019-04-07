package com.fh.shop.backend.api;


import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import java.io.FileWriter;
import java.io.IOException;

public class testMain {
    public static void main(String[] args) {
        //打开浏览器
        CloseableHttpClient client = HttpClientBuilder.create().build();
        //输入网址
        HttpGet httpGet = new HttpGet("http://www.bootcss.com/");
        CloseableHttpResponse response=null;
        FileWriter writer=null;
        try {
            //发送请求
             response = client.execute(httpGet);
            HttpEntity entity = response.getEntity();
            //设置响应格式
            String string = EntityUtils.toString(entity, "utf-8");
            //输出
            System.out.println(string);
            //将输出的内容写入自定义名字的文件夹中
             writer = new FileWriter("D:/aa.html");
            writer.write(string);
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            //关闭连接
            if (null!=writer){
                try {
                    writer.close();
                    writer=null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null!= response){
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
