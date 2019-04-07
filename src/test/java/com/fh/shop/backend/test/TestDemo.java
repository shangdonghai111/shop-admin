package com.fh.shop.backend.test;

import com.fh.shop.backend.brand.TestBrandService;
import com.fh.shop.backend.product.TestProductService;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

import java.util.*;

/**
* @Description:    测试套件
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/2/24 21:18
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/2/24 21:18
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RunWith(Suite.class)
@Suite.SuiteClasses({TestBrandService.class, TestProductService.class})//作用范围
public class TestDemo {
    public static void main(String[] args) {
        Map stuMap=new HashMap();
        stuMap.put("stuName","张三");
        stuMap.put("stuAge","20");
        stuMap.put("stuSex","男");
        /*map循环第一种*/
      /*  Iterator iterator = stuMap.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry next = (Map.Entry) iterator.next();
            System.out.println(next.getKey()+":"+next.getValue());
        }*/
      /*map循环第二种*/
       /* Iterator iterator = stuMap.keySet().iterator();
        while (iterator.hasNext()){
            String key = (String) iterator.next();
            System.out.println(key+":"+stuMap.get(key));
        }*/
        Map stuMap1=new HashMap();
        stuMap1.put("stuName","张三1");
        stuMap1.put("stuAge","201");
        stuMap1.put("stuSex","男1");
        List<String> list1=new ArrayList<>();
        list1.add("三国");
        list1.add("三国1");
        stuMap1.put("mapList",list1);
        Map stuMap2=new HashMap();
        stuMap2.put("stuName","张三2");
        stuMap2.put("stuAge","202");
        stuMap2.put("stuSex","男2");
        List<String> list2=new ArrayList<>();
        list2.add("水浒");
        list2.add("水浒1");
        stuMap1.put("mapList",list2);
        List<Map> list=new ArrayList<>();
       list.add(stuMap);
       list.add(stuMap1);
       list.add(stuMap2);
        for (Map map : list) {
            Iterator iterator = map.keySet().iterator();
            while (iterator.hasNext()){
                String next = (String) iterator.next();
                if(next.equals("mapList")){
                  List<String> mapInfo = (List<String>) map.get(next);
                  StringBuffer stringBuffer=new StringBuffer();
                    for (String s : mapInfo) {
                        stringBuffer.append(s).append(",");
                        System.out.println(next+":"+stringBuffer.toString());
                    }
                }else {
                    System.out.println(next + ":" + map.get(next));
                }
            }
        }


    }
}
