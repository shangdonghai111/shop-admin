package com.fh.shop.backend.product;

import com.fh.shop.backend.biz.product.IProductService;
import com.fh.shop.backend.biz.product.ProductServiceImpl;
import com.fh.shop.backend.po.product.Product;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-common.xml")
public class TestProductService extends AbstractJUnit4SpringContextTests {
    @Resource
    private IProductService productService;
    Product product=new Product();

    @Test
    public void testQueryProduct(){
        List<Product> productList = productService.findProductList(product);
        System.out.println(productList);
    }

    @Test
    public void testAddProduct(){
        product.setProductName("宝马1100");
        product.setProductPrice(2000f);
        productService.add(product);
    }

@Test
    public void testUpdateProduct(){
        product.setId(118);
        product.setProductName("宝马220");
        productService.update(product);
    }

    @Test
    public void testDelProduct(){
        productService.deleteProduct(118);
    }

    @Test
    @Ignore
    public void testDelAllProduct(){
        productService.deleteAll("112,113");
    }

    @Test
    @Ignore
    public void testQueryPageProduct(){
    product.setProductName("宝马");
    product.setMinPrice(20f);
    product.setMaxPrice(60f);
        List<Product> productList = productService.queryProductList(product);
        System.out.println(productList);
    }

}
