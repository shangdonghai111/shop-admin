package com.fh.shop.backend.mapper.dept;

import com.fh.shop.backend.po.dept.Dept;

import java.util.List;

public interface DeptMapper {
    List<Dept> queryDept();

    void addDept(Dept dept);



    Dept queryDeptInfo(Integer id);

    void updateDept(Dept dept);

    void deleteDeptId(Integer deptId);

    Dept queryDeptList(Integer deptId);

    void deletePid(Integer parentId1);

    void deleteDept(List<Integer> ids);

    List<Dept> findChildByChiledId(List<Integer> childNode);

    List<Dept> findDeptByFatherId(Integer id);
}
