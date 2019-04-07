package com.fh.shop.backend.util;

import com.fh.shop.backend.gloable.Gloable;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.model.ObjectMetadata;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.region.Region;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.util.UUID;

public class CosUploadUtil {

    public static String upload(String url) {
        // 1 初始化用户身份信息（secretId, secretKey）。云API秘钥
        COSCredentials cred = new BasicCOSCredentials("AKIDPq44pMdjwviIcibCcrreDXeW9ZliRhLA", "kKFwRxIOFPL7e1JTP5btwjJo57uZ0C9s");
        // 2 设置bucket的区域, COS地域的简称请参照 https://cloud.tencent.com/document/product/436/6224
        // clientConfig中包含了设置 region, https(默认 http), 超时, 代理等 set 方法, 使用可参见源码或者接口文档 FAQ 中说明。
        ClientConfig clientConfig = new ClientConfig(new Region("ap-beijing"));
        // 3 生成 cos 客户端。
        COSClient cosClient = new COSClient(cred, clientConfig);
        // bucket的命名规则为{name}-{appid} ，此处填写的存储桶名称必须为此格式,空间名称
        String bucketName = "fh-1808-1258899193";

        //通过截取来动态上传文件的后缀名
        String fileName = url;
        //上传文件,本地上传的文件
        File localFile = new File(fileName);

        //通过当天时间来作为文件夹的名称.
        String strCurrDate = DateUtil.date2Str(new Date(), DateUtil.Y_M_D);
        // 指定要上传到 COS 上对象键,上传的Cos的文件路径和文件名称。嵌套一层就多一层包结构
        //通过UUID来作为文件名称确保文件不会被覆盖。    通过截取来动态上传文件的后缀名
        String key = strCurrDate + "/" + UUID.randomUUID().toString() + getSuffix(fileName);
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, localFile);
        //获取上传到Cos腾讯云的文件路径
        cosClient.putObject(putObjectRequest);
        cosClient.shutdown();
        Date expiration = new Date(new Date().getTime() + 5 * 60 * 10000);
        URL Url = cosClient.generatePresignedUrl(bucketName, key, expiration);
        //将其转换为String类型
        String filePath = String.valueOf(Url);
        System.out.println(filePath);
        return filePath;
    }

    public static String upload(InputStream is,String fileName){
        //构建cosclient
        COSClient cosClient=null;
        String key="";
        try {
            // 1 初始化用户身份信息（secretId, secretKey）。
            COSCredentials cred = new BasicCOSCredentials(Gloable.COS_ACCESSKEY, Gloable.COS_SECERTKEY);
            // 2 设置bucket的区域, COS地域的简称请参照 https://cloud.tencent.com/document/product/436/6224
            // clientConfig中包含了设置 region, https(默认 http), 超时, 代理等 set 方法, 使用可参见源码或者接口文档 FAQ 中说明。
            ClientConfig clientConfig = new ClientConfig(new Region(Gloable.COS_AREA));
            // 3 生成 cos 客户端。
             cosClient = new COSClient(cred, clientConfig);
            // 指定文件所在的存储桶
            // 指定文件在 COS 上的对象键
            // 指定要上传到的存储桶
            // 指定要上传到 COS 上对象键
            String str = DateUtil.date2Str(new Date(), DateUtil.Y_M_D);
             key = str+"/"+ UUID.randomUUID().toString() +getSuffix(fileName);
            //构建上传请求对象
            ObjectMetadata objectMetadata = new ObjectMetadata();
            int available = 0;
            try {
                available = is.available();
            } catch (IOException e) {
                e.printStackTrace();
            }//获取文件大小
            objectMetadata.setContentLength(available);
            System.out.println(available);
            PutObjectRequest putObjectRequest = new PutObjectRequest(Gloable.COS_BUCKETNAME, key, is,objectMetadata);
            //上传
             cosClient.putObject(putObjectRequest);
        }
       finally {
            if (cosClient!=null){
                //关闭客户端
                cosClient.shutdown();
            }
        }
        return Gloable.COS_URL+ key;
    }

    //测试返回值
    public static void main(String[] args) {
        String upload = upload("d:/img.jpg");

        System.out.println(upload);
    }

    private static String getSuffix(String fileName) {
        int index = fileName.lastIndexOf(".");
        String suffix = fileName.substring(index);
        return suffix;
    }

}