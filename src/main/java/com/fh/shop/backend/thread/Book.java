package com.fh.shop.backend.thread;

public class Book {
    private String bookName;
    private Book(){}
    private static Book book;
    public static Book getInstance(){
        if (book==null){
            book=new Book();
        }
        return book;
    }




    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
}
