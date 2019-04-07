package com.fh.shop.backend.po.city;

import java.io.Serializable;

public class City implements Serializable {
    private static final long serialVersionUID = 4171430088296470897L;

    private Integer id;
    private String cityName;
    private Integer fatherId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public Integer getFatherId() {
        return fatherId;
    }

    public void setFatherId(Integer fatherId) {
        this.fatherId = fatherId;
    }
}
