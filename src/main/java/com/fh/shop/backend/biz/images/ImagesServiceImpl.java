package com.fh.shop.backend.biz.images;


import com.fh.shop.backend.mapper.image.ImageMapper;
import com.fh.shop.backend.po.images.Images;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ImagesServiceImpl implements ImagesService {
    @Autowired
    private ImageMapper imageMapper;

    @Override
    public void add(Images images) {
        imageMapper.add(images);
    }

    @Override
    public Images query(Integer id) {
        return imageMapper.query(id);
    }

    @Override
    public void deleteImagePath(Integer id) {
        imageMapper.deleteImagePath(id);
    }

    @Override
    public void deleteImageList(ArrayList list) {
        imageMapper.deleteImageList(list);
    }
}
