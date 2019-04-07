package com.fh.shop.backend.thread;

public class Main2 {
    public static void main(String[] args) {
        BookThread bookThread = new BookThread();
        for (int i = 0; i < 1000; i++) {
            Thread thread = new Thread(bookThread);
            thread.start();
        }

    }
}
