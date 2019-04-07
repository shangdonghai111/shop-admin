package com.fh.shop.backend.controller;

import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.gloable.Gloable;
import com.fh.shop.backend.util.CosUploadUtil;
import com.fh.shop.backend.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;

@RestController
public class FileController {
    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "uploadHeadImage",method = RequestMethod.POST)
    public ServerResponse uploadHeadImage(@RequestParam MultipartFile headImage){
        //获取输入流
        InputStream inputStream=null;
        try {
            inputStream = headImage.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取文件名
        String filename = headImage.getOriginalFilename();
        //获取文件绝对路径
        String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
        String uploadPath = CosUploadUtil.upload(inputStream, filename);
        //调用工具类  返回相对路径
        //String path = FileUtil.copyFile(inputStream, filename, realPath);

       // System.out.println(realPath +"/"+ path);
        /*return ServerResponse.success(Gloable.SYSTEM_IMAGESPATH+path);
        String upload = CosUploadUtil.upload(realPath+"/"+ path);*/
        return ServerResponse.success(uploadPath);
    }

    @RequestMapping(value = "uploadHeadImageInfo",method = RequestMethod.POST)
    public ServerResponse uploadHeadImageInfo(@RequestParam MultipartFile headImageInfo){
        //获取输入流
        InputStream inputStream=null;
        try {
            inputStream = headImageInfo.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取文件名
        String filename = headImageInfo.getOriginalFilename();
        //获取文件绝对路径
        String realPath = request.getServletContext().getRealPath(Gloable.SYSTEM_IMAGESPATH);
        //调用工具类  返回相对路径
        String path = FileUtil.copyFile(inputStream, filename, realPath);
       /* return ServerResponse.success(Gloable.SYSTEM_IMAGESPATH + path);*/
      System.out.println(realPath +"/"+ path);
        String upload = CosUploadUtil.upload(realPath+"/"+ path);
        return ServerResponse.success(upload);


    }
}
















