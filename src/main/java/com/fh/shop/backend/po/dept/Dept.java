package com.fh.shop.backend.po.dept;

import java.io.Serializable;

public class Dept implements Serializable {
    private static final long serialVersionUID = -2565459431694949716L;
    private Integer id;
    private String deptName;
    private Integer parentId;
    private String remary;
    private String ids;

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getRemary() {
        return remary;
    }

    public void setRemary(String remary) {
        this.remary = remary;
    }
}
