package com.fh.shop.backend.biz;

public class BaseService {
    protected String getColumnData(String orderColumn) {
        return "columns[" + orderColumn + "][data]";
    }
}
