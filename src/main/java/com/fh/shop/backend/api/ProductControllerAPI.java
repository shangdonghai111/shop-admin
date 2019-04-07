package com.fh.shop.backend.api;

import com.fh.shop.backend.biz.product.IProductService;
import com.fh.shop.backend.common.ServerResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController()
@RequestMapping("/api")
public class ProductControllerAPI {
    @Resource
    private IProductService productService;

    /**
    * @Description:    查询商品列表
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/13 18:40
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/13 18:40
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping(value="queryProductApi",method = {RequestMethod.POST,RequestMethod.GET})
    public Object queryProductApi(String callback){
        List<ProductApiVo> productList=productService.queryProductApi();
        if (StringUtils.isNotEmpty(callback)){
            MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(ServerResponse.success(productList));
            mappingJacksonValue.setJsonpFunction(callback);
            return mappingJacksonValue;
        }else {
            return ServerResponse.success(productList);
        }

    }

}
