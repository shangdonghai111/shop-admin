package com.fh.shop.backend.thread;

public class UserMain {
    public static void main(String[] args) {
        UserThread thread = new UserThread();
        for (int i = 0; i <10; i++) {
            Thread thread1 = new Thread(thread);
            thread1.start();
        }
    }
}
