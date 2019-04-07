package com.fh.shop.backend.api;

import java.io.Serializable;

public class ProductApiVo implements Serializable {
    private static final long serialVersionUID = -5547425594573015474L;

    private Integer id;
    private String deptName;
    private float price;
    private String productImage;

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
