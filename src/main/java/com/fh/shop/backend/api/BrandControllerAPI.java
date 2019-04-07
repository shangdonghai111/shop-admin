package com.fh.shop.backend.api;

import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.common.ServerResponse;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("brand")
public class BrandControllerAPI {
    @Resource
    private BrandService brandService;

    @RequestMapping("queryBrandApi")
    public Object queryBrandApi(String callback){
        List<BrandApiVo> brandApiVoList=brandService.queryBrandApi();
        MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(ServerResponse.success(brandApiVoList));
        mappingJacksonValue.setJsonpFunction(callback);
        return mappingJacksonValue;
    }
}
