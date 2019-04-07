package com.fh.shop.backend.biz.city;

import com.fh.shop.backend.mapper.city.CityMapper;
import com.fh.shop.backend.po.city.City;
import com.fh.shop.backend.util.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityServiceImpl implements CityService {
//注入dao
    @Autowired
    private CityMapper cityMapper;

    @Override
    public List<City> queryCityList() {
        CacheManager instance = CacheManager.getInstance();
        Object cityList = instance.getObj("cityList");
        if (cityList!=null){
            return (List<City>) cityList;
        }
        List<City> queryCityList = cityMapper.queryCityList();
        //instance.putObj("cityList",queryCityList);
        instance.putObj("cityList",queryCityList,10);
        return queryCityList;
    }

    @Override
    public void addCity(City city) {
        cityMapper.addCity(city);
        CacheManager.getInstance().remove("cityList");
    }

    @Override
    public void deleteCity(List<Integer> ids) {
        cityMapper.deleteCity(ids);
        CacheManager.getInstance().remove("cityList");
    }

    @Override
    public void updateCity(City city) {
        cityMapper.updateCity(city);
        CacheManager.getInstance().remove("cityList");
    }
}
