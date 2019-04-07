package com.fh.shop.backend.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/upload")
public class upload {
    @RequestMapping("uploadImg")
        public Map uploadImg(@RequestParam(required=false) CommonsMultipartFile empImg){
        Map map=new HashMap();
        String filename = empImg.getOriginalFilename();
        if (StringUtils.isNotBlank(filename)){
            System.out.println("文件名称为"+filename);

        }
        File file = new File("F:\\新建文件夹");
        map.put("url",file);
        return map;
        }
}
