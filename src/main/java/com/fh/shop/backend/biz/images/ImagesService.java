package com.fh.shop.backend.biz.images;

import com.fh.shop.backend.po.images.Images;

import java.util.ArrayList;

public interface ImagesService {
    void add(Images images);

    Images query(Integer id);

    void deleteImagePath(Integer id);

    void deleteImageList(ArrayList list);
}
