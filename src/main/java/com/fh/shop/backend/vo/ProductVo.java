package com.fh.shop.backend.vo;

import java.io.Serializable;
import java.util.Date;

public class ProductVo implements Serializable {

    private static final long serialVersionUID = -628363457602193346L;
    private Integer id;
    private String productName;
    private Float productPrice;
    private Date entrtyTime;
    private Date updateTime;
    private String pathUrl;
    private String brandName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    public Date getEntrtyTime() {
        return entrtyTime;
    }

    public void setEntrtyTime(Date entrtyTime) {
        this.entrtyTime = entrtyTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getPathUrl() {
        return pathUrl;
    }

    public void setPathUrl(String pathUrl) {
        this.pathUrl = pathUrl;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
