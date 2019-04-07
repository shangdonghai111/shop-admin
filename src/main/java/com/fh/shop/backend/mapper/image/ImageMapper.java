package com.fh.shop.backend.mapper.image;

import com.fh.shop.backend.po.images.Images;

import java.util.ArrayList;

public interface ImageMapper {
    void add(Images images);

    Images query(Integer id);

    void deleteImagePath(Integer id);

    void deleteImageList(ArrayList list);
}
