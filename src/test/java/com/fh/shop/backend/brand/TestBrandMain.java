package com.fh.shop.backend.brand;

import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.po.brand.Brand;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;
import java.util.List;

public class TestBrandMain {
    public static void main(String[] args) {
        //加载spring的配置文件
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/spring-common.xml");
        //获取bean的id 去加载service
        BrandService brandService = (BrandService) context.getBean("brandServiceImpl");

        //查询测试
       /* List<Brand> brandList = brandService.queryList();
        System.out.println(brandList);*/

       //增加测试
        Brand brand = new Brand();
     /*  brand.setBrandName("小米");
        brand.setEntrtyTime(new Date());
        brand.setUpdateTime(new Date());
        brandService.add(brand);
*/
   //修改测试
    /*brand.setId(33);
    brand.setBrandName("苹果");
    brandService.update(brand);*/

    //删除测试
        //brandService.deleteOne(33);
    //批量删除
        brandService.deleteAll("34,35");





    }
}
