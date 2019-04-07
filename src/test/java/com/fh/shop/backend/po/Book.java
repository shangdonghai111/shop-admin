package com.fh.shop.backend.po;

public class Book {
    private String name;

    private Book(){
    }
    private static final Book book=new Book();
    public static  Book getInstance(){
        return book;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
