package com.fh.shop.backend.biz.user;



import com.fh.shop.backend.po.user.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserService {
	 User queryUserByUserName(String userName);

	 void add(User user);

    void updateLastLoginTime(User userDB);


	void resultLoginCount(Integer id);

	void increaseLoginCount(Integer id);


	void updateErrorCountAndErrorLoginTime(User user);

    void updateErrorCount(Integer id);

	void updateErrorTimeCount(Integer id);

	void resultErrorCount(Integer id);

	void updateErrorStatus(Integer id);

	void resultErrorStatus(Integer id);

    Long findUserListCount(User user);




	User queryStatus(Integer id);

	void updateErrorStat(Integer id);

	void deleteAll(String ids);



	List<User> queryUserList(User user);

	void updateAllDept(String ids);


    void updateAllDeptId(List<Integer> ids, Integer deptId);


	User findUserById(Integer id);

	void updateUser(User user);

    List<User> findUserByDeptName(String deptName);
}
