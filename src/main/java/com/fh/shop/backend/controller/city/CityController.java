package com.fh.shop.backend.controller.city;

import com.fh.shop.backend.biz.city.CityService;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.po.city.City;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("city")
public class CityController {
    //注入service
    @Resource
    private CityService cityService;
    /**
    * @Description:    跳转至地区列表
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/12 22:24
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/12 22:24
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("toCityList")
    public String toCityList(){
        return "city/cityList";
    }
    /**
    * @Description:    查询
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/12 22:37
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/12 22:37
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
@RequestMapping("queryCityList")
@ResponseBody
    public ServerResponse queryCityList(){
      List<City> cityList = cityService.queryCityList();
        return ServerResponse.success(cityList);
    }
    /**
    * @Description:    增加
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/12 23:52
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/12 23:52
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("addCity")
    @ResponseBody
    public ServerResponse addCity(City city){
        cityService.addCity(city);
    return ServerResponse.success(city);
    }
    /**
    * @Description:    删除
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/13 0:01
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/13 0:01
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("deleteCity")
    @ResponseBody
    public ServerResponse deleteCity(@RequestParam("ids[]") List<Integer> ids){
        cityService.deleteCity(ids);
        return ServerResponse.success();
    }
    @RequestMapping("updateCity")
    @ResponseBody
    public ServerResponse updateCity(City city){
        cityService.updateCity(city);
        return ServerResponse.success();
    }

}
