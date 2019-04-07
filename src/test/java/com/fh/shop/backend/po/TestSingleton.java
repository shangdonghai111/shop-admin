package com.fh.shop.backend.po;

public class TestSingleton {

    String name = null;
    private TestSingleton() {
    }

    private static TestSingleton instance = null;

    public static TestSingleton getInstance() {
        if (instance==null){
            instance=new TestSingleton();
        }
        return instance;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void print() {
        System.out.println("the name is " + name);
    }

    public static void main(String[] args) {
        // TODO 自动生成的方法存根
        TestSingleton ts1 = TestSingleton.getInstance();
        ts1.setName("12345");
        TestSingleton ts2 = TestSingleton.getInstance();
        ts2.setName("56789");

        ts1.print();
        ts2.print();
        if(ts1 == ts2){
            System.out.println("创建的是同一个实例");
        }else{
            System.out.println("创建的不是同一个实例");
        }

    }
}
