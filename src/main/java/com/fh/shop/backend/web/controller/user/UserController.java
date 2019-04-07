package com.fh.shop.backend.web.controller.user;

import com.fh.shop.backend.annotation.LogAnnotation;
import com.fh.shop.backend.biz.dept.DeptService;
import com.fh.shop.backend.biz.user.UserService;
import com.fh.shop.backend.common.ResponseEnum;
import com.fh.shop.backend.common.ServerResponse;
import com.fh.shop.backend.gloable.Gloable;
import com.fh.shop.backend.po.dept.Dept;
import com.fh.shop.backend.po.log.LogInfo;
import com.fh.shop.backend.po.user.User;
import com.fh.shop.backend.util.DateUtil;
import com.fh.shop.backend.util.FileUtil;
import com.fh.shop.backend.util.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userService;
	@Resource
	private DeptService deptService;


	
	/**
	 * <pre>login(根据用户名查询)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月10日 下午2:23:51    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月10日 下午2:23:51    
	 * 修改备注： 
	 * @param user
	 * @return</pre>
	 */
	@RequestMapping("login")
	@ResponseBody
	public ServerResponse login(User user,HttpServletRequest request,LogInfo logInfo){
		
		//user是前台传过来的 userDB是从数据库查询出来的
		String userName = user.getUserName();
		String userPwd = user.getUserPwd();
		String imageCode = user.getImageCode();
		User userDB = userService.queryUserByUserName(userName);
        Date currDate = new Date();
        //更新登录次数
        //当前时间
        Date currDay = DateUtil.str2Date(DateUtil.date2Str(currDate, DateUtil.FULL_DATE), DateUtil.Y_M_D);

		try {
			if(StringUtils.isEmpty(userName) || StringUtils.isEmpty(userPwd) ||StringUtils.isEmpty(imageCode)){
				return ServerResponse.error(ResponseEnum.USERNAME_USERPWD_EMPTY);
				}
			//取到code在session中的值
			String code = (String) request.getSession().getAttribute(Gloable.SYSTEM_IMAGECODE);
			if (!code.equals(imageCode)){
				return ServerResponse.error(ResponseEnum.IMAGECODE_ERROR);
			}

			if(userDB==null){
				return ServerResponse.error(ResponseEnum.USERNAME_ERROR);
				}
			//如果账号的状态为1说明账号是锁定状态
            if (userDB.getUserStatus()==Gloable.ERROR_STATUS){
                //否则判断是否是同一天登录
                Date str2Date = DateUtil.str2Date(DateUtil.date2Str(userDB.getErrorLoginTime(), DateUtil.FULL_DATE), DateUtil.Y_M_D);
                if (currDay.after(str2Date)){
                    userService.resultErrorStatus(userDB.getId());
                }else {
                    return ServerResponse.error(ResponseEnum.USER_LOCKERROR);
                }


            }
			String userDBPwd = userDB.getUserPwd();
			String salt = userDB.getSalt();//查询数据库中加的盐
			String stringMD5 = MD5Util.getStringMD5(userPwd + salt);
			Date date = new Date();
			if(!userDBPwd.equals(stringMD5)){
				//增加错误登录次数和错误登录时间
					/*user.setErrorLoginTime(date);
					user.setErrorCount(userDB.getErrorCount()+1);
					userService.updateErrorCountAndErrorLoginTime(user);
					if (userDB.getErrorCount()>1){
						user.setErrorLoginTime(date);
						user.setErrorCount(userDB.getErrorCount()+1);
						user.setUserStatus(1);
						userService.updateErrorCountAndErrorLoginTime(user);
						return ServerResponse.error(ResponseEnum.USER_LOCKERROR);
					}*/
					//判断登录错误时间为空，就说明是第一次登录错误
                Date errorLoginTime = userDB.getErrorLoginTime();
                if (errorLoginTime==null){
                    //第一次登录就错误次数为1，并更新错误时间
                    userService.updateErrorCount(userDB.getId());
                }else {
                    //否则判断是否是同一天登录
                    Date str2Date = DateUtil.str2Date(DateUtil.date2Str(userDB.getErrorLoginTime(), DateUtil.FULL_DATE), DateUtil.Y_M_D);
                    if (currDay.after(str2Date)){
                        //不是同一天登录，就重置错误次数为1
                        userService.updateErrorCount(userDB.getId());
                    }else {

                        if (userDB.getErrorCount()>Gloable.ERROR_COUNT-1){
                            userService.updateErrorStatus(userDB.getId());
                            return ServerResponse.error(ResponseEnum.USER_LOCKERROR);
                        }
                    }
					//如果是同一天登录就将错误次数+1，并更新错误时间
					userService.updateErrorTimeCount(userDB.getId());

                }

				return ServerResponse.error(ResponseEnum.USERPWD_ERROR);
				}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ServerResponse.error();
		}
//把查询出来的放进session中方便从session中去取
		request.getSession().setAttribute(Gloable.USER_SESSION, userDB);
		//登录成功将错误登录次数重置为0
        userService.resultErrorCount(userDB.getId());

		//记录本次的登录时间

		//查询数据库错误时间

		Date errorLoginTime = userDB.getErrorLoginTime();

		Date errorLoginTimea = DateUtil.str2Date(DateUtil.date2Str(errorLoginTime, DateUtil.FULL_DATE), DateUtil.Y_M_D);
		if(currDay.after(errorLoginTimea)){
			user.setErrorLoginTime(currDate);
			user.setErrorCount(0);
			user.setUserStatus(0);
			userService.updateErrorCountAndErrorLoginTime(user);
		}

		User userDBA = userService.queryUserByUserName(userName);
		if (userDBA.getUserStatus()==1){
			return ServerResponse.error(ResponseEnum.USER_LOCKERROR);
		}
		user.setErrorCount(0);
		user.setErrorLoginTime(currDate);
		userService.updateErrorCountAndErrorLoginTime(user);

		//上次登录时间
		Date loginTime = userDB.getLoginTime();
		if (loginTime==null){
			userDB.setLoginTime(currDate);
			//证明是第一次登录
			userService.resultLoginCount(userDB.getId());
		}else {
			Date lastLoginTime = DateUtil.str2Date(DateUtil.date2Str(loginTime, DateUtil.FULL_DATE), DateUtil.Y_M_D);
			if (currDay.after(lastLoginTime)){
				//重置为1
				userService.resultLoginCount(userDB.getId());
			}else {
				//加1
				userService.increaseLoginCount(userDB.getId());
			}
		}

		userDB.setLoginTime(currDate);
		userService.updateLastLoginTime(userDB);
		return ServerResponse.success();
		
	}
	/**
	* @Description:    更改账号状态
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/3/2 21:26
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/3/2 21:26
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("updateStatus")
	public String updateStatus(Integer id){
		User user=userService.queryStatus(id);
		if (user.getUserStatus()==0){
			userService.updateErrorStatus(id);
		}else{
			userService.resultErrorStatus(id);
		}
		return "redirect:toQueryUserList.jhtml";
	}
	/**
	 * <pre>toLogin(跳转至登录后的页面)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月10日 下午3:02:31    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月10日 下午3:02:31    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toLogin")
	public String toLogin(){
		return "index";
	}
	/**
	 * <pre>toAdd(跳转至增加页面)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月15日 上午10:33:26    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月15日 上午10:33:26    
	 * 修改备注： 
	 * @return</pre>
	 */
	@RequestMapping("toAdd")
	public String toAdd(ModelMap map){
		//查询所有部门
		List<Dept> deptList = deptService.queryDept();
		map.put("deptList",deptList);
		return "user/add";
	}
	/**
	 * <pre>add(增加的方法)   
	 * 创建人：ShangDongHai q540662261@126.com   
	 * 创建时间：2019年1月15日 上午10:35:29    
	 * 修改人：ShangDongHai q540662261@126.com     
	 * 修改时间：2019年1月15日 上午10:35:29    
	 * 修改备注： 
	 * @param user
	 * @return</pre>
	 */
	@RequestMapping("add")
	@ResponseBody
	public ServerResponse add(User user){
		userService.add(user);
		return ServerResponse.success();
	}
	/**
	* @Description:    用户表分页查询
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/2/28 19:01
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/2/28 19:01
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("queryUserList")
	@ResponseBody
	public Map queryUserList(ModelMap map,
                             Integer draw,
                             Integer start,
                             Integer length,
                             User user
                             ){
	    //转换部门列表
        String deptIds = user.getDeptIds();
        if (StringUtils.isNotEmpty(deptIds)){
            String[] deptArr = deptIds.split(",");
            List<Integer> idList=new ArrayList<>();
            for (String s : deptArr) {
                idList.add(Integer.parseInt(s));
            }
            user.setDeptList(idList);
        }

        //给开始条数和每页条数赋值
		user.setStartPos(start);
		user.setPageSize(length);
		// 获取总条数
		Long totalCount=userService.findUserListCount(user);
		// 获取分页列表
		List<User> list=userService.queryUserList(user);
		HashMap hashMap = new HashMap();
		hashMap.put("draw",draw);
		hashMap.put("recordsTotal",totalCount);
		hashMap.put("recordsFiltered",totalCount);
		hashMap.put("data",list);
		return hashMap;

	}
	/**
	* @Description:    跳转至分页查询
	* @Author:         ShangDongHai q540662261@126.com
	* @CreateDate:     2019/2/28 21:02
	* @UpdateUser:     Shangdonghai
	* @UpdateDate:     2019/2/28 21:02
	* @UpdateRemark:   修改内容
	* @Version:        1.0
	*/
	@RequestMapping("toQueryUserList")
	public String toQueryUserList(){
		return "user/userList";
	}
/**
* @Description:    批量删除
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/5 22:52
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/5 22:52
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RequestMapping("deleteAll")
@ResponseBody
@LogAnnotation("批量删除商品")
public ServerResponse deleteAll(String ids, HttpServletResponse response) {
	userService.deleteAll(ids);

	return ServerResponse.success();

}
/**
* @Description:   根据id获取用户信息
* @Author:         ShangDongHai q540662261@126.com
* @CreateDate:     2019/3/9 19:27
* @UpdateUser:     Shangdonghai
* @UpdateDate:     2019/3/9 19:27
* @UpdateRemark:   修改内容
* @Version:        1.0
*/
@RequestMapping("findUserById")
@ResponseBody
public ServerResponse findUserById(Integer id){
    User user=userService.findUserById(id);
    return ServerResponse.success(user);
}
	@RequestMapping("updateAllDeptaaa")
	@ResponseBody
	@LogAnnotation("批量删除商品")
	public ServerResponse updateAllDept(String ids, HttpServletResponse response) {
		userService.updateAllDept(ids);

		return ServerResponse.success();

	}
    @RequestMapping("updateAllDeptId")
    @ResponseBody
    @LogAnnotation("批量修改部门")
    public ServerResponse updateAllDeptId(@RequestParam("ids[]") List<Integer> ids ,Integer deptId) {
        userService.updateAllDeptId(ids,deptId);
        return ServerResponse.success();

    }
   /**
   * @Description:    java类作用描述
   * @Author:         ShangDongHai q540662261@126.com
   * @CreateDate:     2019/3/9 21:24
   * @UpdateUser:     Shangdonghai
   * @UpdateDate:     2019/3/9 21:24
   * @UpdateRemark:   修改用户信息
   * @Version:        1.0
   */
    @RequestMapping(value = "updateUser")
    @ResponseBody
    public ServerResponse updateUser(User user){
        userService.updateUser(user);
        return ServerResponse.success();
    }
    /**
    * @Description:    按部门导出excel
    * @Author:         ShangDongHai q540662261@126.com
    * @CreateDate:     2019/3/10 9:39
    * @UpdateUser:     Shangdonghai
    * @UpdateDate:     2019/3/10 9:39
    * @UpdateRemark:   修改内容
    * @Version:        1.0
    */
    @RequestMapping("importExcelByDept")
    @ResponseBody
    public void importExcelByDept(HttpServletResponse response,
                                  @RequestParam("childNode") List<Integer> childNode){
        //根据选中的节点的子节点id查看子节点信息
        List<Dept> deptList=deptService.findChildByChiledId(childNode);
        //创建workbook
        XSSFWorkbook wookBook=new XSSFWorkbook();
        //日期样式
        XSSFCellStyle dateStyle = wookBook.createCellStyle();
        dateStyle.setDataFormat(wookBook.createDataFormat().getFormat("yyyy-MM-dd hh:mm:ss"));
        for (Dept dept : deptList) {
            //创建sheet
            XSSFSheet sheet = wookBook.createSheet(dept.getDeptName());
            //创建标题行并赋值
            XSSFRow titleRrow = sheet.createRow(0);
            XSSFCell Cell1 = titleRrow.createCell(0);
            Cell1.setCellValue("用户名");
            XSSFCell Cell2 = titleRrow.createCell(1);
            Cell2.setCellValue("登陆状态");
            XSSFCell Cell3 = titleRrow.createCell(2);
            Cell3.setCellValue("真是姓名");
            XSSFCell Cell4 = titleRrow.createCell(3);
            Cell4.setCellValue("生日");
            XSSFCell Cell5 = titleRrow.createCell(4);
            Cell5.setCellValue("性别");
            XSSFCell Cell6 = titleRrow.createCell(5);
            Cell6.setCellValue("薪资");
            XSSFCell Cell7 = titleRrow.createCell(6);
            Cell7.setCellValue("所在部门");

            //根据父节点查看所有的子部门
            List<Dept> deptsList=deptService.findDeptByFatherId(dept.getId());
            for (Dept deptInfo : deptsList) {
                //根据部门名称查看用户信息
                List<User> userList = userService.findUserByDeptName(deptInfo.getDeptName());
                for (int i=0;i<userList.size();i++) {
                    User userInfo=userList.get(i);
                    //创建内容行并赋值
                    XSSFRow bodyRrow = sheet.createRow(i+1);

                    XSSFCell userNameCell = bodyRrow.createCell(0);
                    userNameCell.setCellValue(userInfo.getUserName());

                    XSSFCell statusCell = bodyRrow.createCell(1);
                    statusCell.setCellValue(userInfo.getUserStatus());

                    XSSFCell realNameCell = bodyRrow.createCell(2);
                    realNameCell.setCellValue(userInfo.getUserRealName());

                    XSSFCell birthdayCell = bodyRrow.createCell(3);
                    birthdayCell.setCellValue(userInfo.getBirthday());

                    XSSFCell sexCell = bodyRrow.createCell(4);
                    sexCell.setCellValue(userInfo.getSex());

                    XSSFCell salaryCell = bodyRrow.createCell(5);
                    salaryCell.setCellValue(userInfo.getSalary());

                    XSSFCell deptNameCell = bodyRrow.createCell(6);
                    deptNameCell.setCellValue(userInfo.getDept().getDeptName());
                }
            }

        }
        //导出excel
        FileUtil.excelDownload(wookBook,response);

    }


}

