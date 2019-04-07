package com.fh.shop.backend.brand;


import com.fh.shop.backend.po.Book;
import com.fh.shop.backend.po.Student;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Test {
    public static void main(String[] args) {
   /*   Student s1=new Student();
        s1.setStuName("小明");
        s1.setStuAge(18);
        Student s2=new Student();
        s2.setStuName("小红");
        s2.setStuAge(25);
        System.out.println(s1);
        System.out.println(s2);*/
       /*   try {
            Student s = (Student) Class.forName("com.fh.shop.backend.po.Student").newInstance();
            s.setStuName("小花");
            System.out.println(s);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }*/
       /* Book book = (Book) createObj("com.fh.shop.backend.po.Book");
        book.setName("aaaa");

        Student student = (Student) createObj("com.fh.shop.backend.po.Student");
        student.setStuName("zhangsan");
        System.out.println(book+"==========="+student);*/
/*
       Book b1=new Book();
       b1.setName("三国");

        Book b2=new Book();
        b2.setName("西游");
        System.out.println(b1==b2);*/

       /* Book b1 = Book.getInstance();
        b1.setName("小花");

        Book b2 = Book.getInstance();
        b2.setName("小明");
        System.out.println(b1==b2);
        System.out.println(b1.getName());
        System.out.println(b2.getName());
        System.out.println(b1);
        System.out.println(b2);*/




        //加载配置文件
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:demo.xml");
        //根据bean的id获取对应的bean
        Student student=(Student) context.getBean("s1");
        student.setStuName("李四");

        Student student1=(Student) context.getBean("s1");
        System.out.println(student1.getStuName());



    }
    public static Object createObj(String name){
      /*  Object result=null;
        if (name.equals("book")){
            result=new Book();
        }else  if(name.equals("student")){
            result=new Student();
        }
        return result;*/
     /*   try {
            return Class.forName(name).newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }*/
        return null;
    }
}
