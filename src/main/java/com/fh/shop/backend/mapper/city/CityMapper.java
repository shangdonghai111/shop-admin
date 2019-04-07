package com.fh.shop.backend.mapper.city;

import com.fh.shop.backend.po.city.City;

import java.util.List;

public interface CityMapper {

    List<City> queryCityList();

    void addCity(City city);

    void deleteCity(List<Integer> ids);

    void updateCity(City city);
}
