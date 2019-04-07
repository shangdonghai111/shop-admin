package com.fh.shop.backend.thread;

public class Main {
    public static void main(String[] args) {
       System.out.println(Thread.currentThread().getName());
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        for (int i = 0; i < 10; i++) {
            Thread t1 = new Thread(new ThreadInfo());
            t1.start();
        }

    }
}
