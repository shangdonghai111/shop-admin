package com.fh.shop.backend.biz.dept;

import com.fh.shop.backend.mapper.dept.DeptMapper;
import com.fh.shop.backend.po.dept.Dept;
import com.fh.shop.backend.util.CacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {
    @Autowired//注入dao
    private DeptMapper deptMapper;

    @Override
    public List<Dept> queryDept() {
        CacheManager instance = CacheManager.getInstance();
        Object deptListInfo = instance.getObj("deptList");
        if (deptListInfo!=null){
            return (List<Dept>) deptListInfo;
        }

        List<Dept> deptList = deptMapper.queryDept();
        instance.putObj("deptList",deptList);
        return deptList;
    }

    @Override
    public void addDept(Dept dept) {
        deptMapper.addDept(dept);
        CacheManager instance = CacheManager.getInstance();
        instance.remove("deptList");

    }



    @Override
    public Dept queryDeptInfo(Integer id) {

        Dept dept = deptMapper.queryDeptInfo(id);
        return dept;
    }

    @Override
    public void updateDept(Dept dept) {
        deptMapper.updateDept(dept);
        CacheManager instance = CacheManager.getInstance();
        instance.remove("deptList");
    }

    @Override
    public void deleteDeptId(Integer deptId) {
        deptMapper.deleteDeptId(deptId);
    }

    @Override
    public Dept queryDeptList(Integer deptId) {
        Dept dept = deptMapper.queryDeptList(deptId);
        return dept;
    }

    @Override
    public void deletePid(Integer parentId1) {
        deptMapper.deletePid(parentId1);
    }

    @Override
    public void deleteDept(List<Integer> ids) {
        deptMapper.deleteDept(ids);
        CacheManager instance = CacheManager.getInstance();
        instance.remove("deptList");
    }

    @Override
    public List<Dept> findChildByChiledId(List<Integer> childNode) {
        List<Dept> childByChiledId = deptMapper.findChildByChiledId(childNode);
        return childByChiledId;
    }

    @Override
    public List<Dept> findDeptByFatherId(Integer id) {
        List<Dept> deptList = deptMapper.findDeptByFatherId(id);
        if (!deptList.isEmpty()){
            for (int i = 0; i < deptList.size(); i++) {
                Dept dept = deptList.get(i);
                this.findDeptByFatherId(dept.getId());
            }
        }
        return deptList;
    }
}
