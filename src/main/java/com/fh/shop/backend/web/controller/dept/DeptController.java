package com.fh.shop.backend.web.controller.dept;

import com.fh.shop.backend.biz.dept.DeptService;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.po.dept.Dept;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;


@Controller
@ResponseBody
@RequestMapping("dept")
public class DeptController {
    //注入service
@Resource
    private DeptService deptService;
/**
* @Description:    查询所有部门
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/3 15:28
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/3 15:28
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RequestMapping("queryDept")
public ServerResponse queryDept(){
    List<Dept> deptList=deptService.queryDept();

    return ServerResponse.success(deptList);
}
/**
* @Description:    增加部门
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/4 22:18
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/4 22:18
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RequestMapping("addDept")
public ServerResponse addDept(Dept dept){
    deptService.addDept(dept);
    return ServerResponse.success(dept);
}
/**
* @Description:    java类作用描述
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/4 23:49
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/4 23:49
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RequestMapping("deleteDept")
@ResponseBody
public ServerResponse deleteDept(@RequestParam("ids[]") List<Integer> ids){
    deptService.deleteDept(ids);
    return ServerResponse.success();
}
/**
* @Description:    修改部门
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/6 14:19
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/6 14:19
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
    @RequestMapping("updateDept")
    public ServerResponse updateDept(Dept dept){
        deptService.updateDept(dept);
        return ServerResponse.success();
    }
}
