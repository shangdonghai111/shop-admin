package com.fh.shop.backend.mapper.user;



import com.fh.shop.backend.po.user.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

public interface UserMapper {

	 User queryUserByUserName(String userName);
	 void add(User user);

    void updateLastLoginTime(User userDB);

	void resultLoginCount(Integer id);

	void increaseLoginCount(Integer id);


	void updateErrorCountAndErrorLoginTime(User user);

    void updateErrorCount(@Param("id") Integer id, @Param("currDay") Date currDay);

	void updateErrorTimeCount(@Param("id") Integer id, @Param("currDay") Date date);

	void resultErrorCount(Integer id);

	void updateErrorStatus(@Param("id") Integer id,@Param("currDay") Date date);

	void resultErrorStatus(Integer id);

    Long findUserListCount(User user);

	List<User> queryUserList(User user);

	User queryStatus(Integer id);

	void updateErrorStat(Integer id);

    void deleteAll(List<Integer> list);

	void updateAllDept(List<Integer> list);


    void updateAllDeptId(@Param("idList") List<Integer> ids, @Param("deptId") Integer deptId);

	User findUserById(Integer id);

	void updateUser(User user);

    List<User> findUserByDeptName(String deptName);
}
