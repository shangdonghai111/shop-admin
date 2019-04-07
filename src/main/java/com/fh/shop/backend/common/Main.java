package com.fh.shop.backend.common;

import com.fh.shop.backend.util.DateUtil;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.model.PutObjectResult;
import com.qcloud.cos.region.Region;

import java.io.File;
import java.util.Date;
import java.util.UUID;

public class Main {
    public static void main(String[] args) {
        // 1 初始化用户身份信息（secretId, secretKey）。
        COSCredentials cred = new BasicCOSCredentials("AKIDPq44pMdjwviIcibCcrreDXeW9ZliRhLA", "kKFwRxIOFPL7e1JTP5btwjJo57uZ0C9s");
// 2 设置bucket的区域, COS地域的简称请参照 https://cloud.tencent.com/document/product/436/6224
// clientConfig中包含了设置 region, https(默认 http), 超时, 代理等 set 方法, 使用可参见源码或者接口文档 FAQ 中说明。
        ClientConfig clientConfig = new ClientConfig(new Region("ap-beijing"));
// 3 生成 cos 客户端。
        COSClient cosClient = new COSClient(cred, clientConfig);
// bucket的命名规则为{name}-{appid} ，此处填写的存储桶名称必须为此格式
        String fileName="F:/img/29.jpg";
        File localFile = new File(fileName);
        String bucketName = "fh-1808-1258899193";
        // 指定文件所在的存储桶
// 指定文件在 COS 上的对象键



// 指定要上传到的存储桶
// 指定要上传到 COS 上对象键
        String str = DateUtil.date2Str(new Date(), DateUtil.Y_M_D);
        String key = str+"/"+ UUID.randomUUID().toString() +getSuffix(fileName);
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, key, localFile);
        PutObjectResult putObjectResult = cosClient.putObject(putObjectRequest);
        System.out.println(putObjectRequest);

    }



    private static String getSuffix(String fileName) {
        int index = fileName.lastIndexOf(".");
        String suffix = fileName.substring(index);
        return suffix;
    }
}
