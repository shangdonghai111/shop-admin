package com.fh.shop.backend.product;

import com.fh.shop.backend.biz.product.IProductService;
import com.fh.shop.backend.biz.product.ProductServiceImpl;
import com.fh.shop.backend.po.product.Product;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class TestProductMain {
    public static void main(String[] args) {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring/spring-common.xml");
        IProductService productServiceImpl = (IProductService) context.getBean("productServiceImpl");
       Product product=new Product();
       //查询
        /*List<Product> list = productServiceImpl.findProductList(product);
        System.out.println(list);*/
        //增加
       /*product.setProductName("哈哈");
        productServiceImpl.add(product);*/
      //修改
   /*     product.setId(114);
        product.setProductName("hhh");
        productServiceImpl.update(product);*/
   //删除
       /* productServiceImpl.deleteProduct(114);*/
        //批量删除
        /*productServiceImpl.deleteAll("115,116");*/

    }
}
