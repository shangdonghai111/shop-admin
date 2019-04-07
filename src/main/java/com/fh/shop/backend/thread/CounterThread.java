package com.fh.shop.backend.thread;

public class CounterThread implements Runnable {
    private int count;
    @Override
    public void run() {
     increate();
    }
    public synchronized void increate(){
        count++;
        System.out.println("=========================="+count);
    }

}
