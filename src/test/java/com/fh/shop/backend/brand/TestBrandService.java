package com.fh.shop.backend.brand;

import com.fh.shop.backend.biz.brand.BrandService;
import com.fh.shop.backend.po.brand.Brand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-common.xml")
public class TestBrandService extends AbstractJUnit4SpringContextTests {
    @Resource()
    private BrandService brandService;
    Brand brand = new Brand();

    @Test
    public void testAddBrand(){
        brand.setBrandName("小米1");
        brand.setEntrtyTime(new Date());
        brand.setUpdateTime(new Date());
        brandService.add(brand);
    }
    @Test
    public void testUpdateBrand(){
        brand.setId(37);
        brand.setBrandName("华为");
        brand.setEntrtyTime(new Date());
        brand.setUpdateTime(new Date());
        brandService.update(brand);
    }
    @Test
    public void testQueryBrand(){
        List<Brand> brandList = brandService.queryList();
        System.out.println(brandList);
    }
    @Test
    public void testDeleteBrand(){
        brand.setId(37);
        brandService.deleteOne(brand.getId());
    }

    public void testDelAllBrand(){
        brandService.deleteAll("31,32");
    }

}
