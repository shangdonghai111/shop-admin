package com.fh.shop.backend.biz.city;

import com.fh.shop.backend.po.city.City;

import java.util.List;

public interface CityService {

    List<City> queryCityList();

    void addCity(City city);

    void deleteCity(List<Integer> ids);

    void updateCity(City city);
}
