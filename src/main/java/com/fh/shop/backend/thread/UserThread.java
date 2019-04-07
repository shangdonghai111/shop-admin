package com.fh.shop.backend.thread;

public class UserThread implements Runnable {
    @Override
    public void run() {
        User user = User.getInstance();
        System.out.println(user);
    }
}
