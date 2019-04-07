package com.fh.shop.backend.po;



public class Student {
    private String stuName;
    private int stuAge;

    //无参构造
    public Student() {

    }
    //有参构造
    public Student(String stuName,int stuAge){
        this.stuName=stuName;
        this.stuAge=stuAge;
    }

    public String getStuName() {
        return stuName;
    }
    public void setStuName(String stuName) {
        this.stuName = stuName;
    }
    public int getStuAge() {
        return stuAge;
    }
    public void setStuAge(int stuAge) {
        this.stuAge = stuAge;
    }
}
