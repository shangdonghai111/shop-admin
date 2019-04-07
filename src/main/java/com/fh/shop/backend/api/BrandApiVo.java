package com.fh.shop.backend.api;

import java.io.Serializable;

public class BrandApiVo implements Serializable {
    private static final long serialVersionUID = -2959007942433907559L;

    private Integer id;
    private String brandName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
