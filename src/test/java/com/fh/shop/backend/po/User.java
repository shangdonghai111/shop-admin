package com.fh.shop.backend.po;

public class User {

    private User() {

    }

    private static User user = null;

    public static User getInstance() {
        if (user == null) {
            user = new User();
        }
        return user;
    }
}
