package com.fh.shop.backend.thread;

import java.util.Hashtable;

public class BookThread implements Runnable {
    @Override
    public void run() {
        Book book = Book.getInstance();
        System.out.println(book);
        new Hashtable<>();
    }
}
