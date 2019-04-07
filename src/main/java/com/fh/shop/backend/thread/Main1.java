package com.fh.shop.backend.thread;

public class Main1 {
    public static void main(String[] args) {
        CounterThread counterThread = new CounterThread();
        for (int i=0;i<100;i++){
            Thread thread = new Thread(counterThread);
            thread.start();
        }
    }

}
