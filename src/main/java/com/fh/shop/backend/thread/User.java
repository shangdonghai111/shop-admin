package com.fh.shop.backend.thread;

public class User {
    private User(){}
    private static User user;
    public static User getInstance(){
        if (null==user){
            synchronized (user){
                if (null==user){
                    user = new User();
                }
            }
        }
        return user;
    }

    private String userName;


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
