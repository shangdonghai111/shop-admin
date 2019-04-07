package com.fh.shop.backend.thread;

public class ThreadInfo implements Runnable {
    @Override
    public void run() {
        System.out.println("当前线程"+Thread.currentThread().getName());
    }
}
