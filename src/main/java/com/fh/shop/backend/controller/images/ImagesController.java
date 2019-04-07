package com.fh.shop.backend.controller.images;

import com.fh.shop.backend.biz.images.ImagesService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@Controller
@RequestMapping("image")
public class ImagesController {
    @Resource
    private ImagesService imagesService;
}
