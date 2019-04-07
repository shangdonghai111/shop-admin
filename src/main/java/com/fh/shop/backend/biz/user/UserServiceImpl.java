package com.fh.shop.backend.biz.user;

import java.util.*;

import javax.annotation.Resource;

import com.fh.shop.backend.util.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.fh.shop.backend.mapper.user.UserMapper;
import com.fh.shop.backend.po.user.User;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UserServiceImpl implements UserService{
	@Resource
	private UserMapper userMapper;

	public User queryUserByUserName(String userName) {
		User queryUserByUserName = userMapper.queryUserByUserName(userName);
		return queryUserByUserName;

	
	}

	@Override
	public void add(User user) {
		String s= UUID.randomUUID().toString();
		user.setSalt(s);
		String md5 = MD5Util.getStringMD5(MD5Util.getStringMD5(user.getUserPwd()) + s);
		user.setUserPwd(md5);
		userMapper.add(user);
	}

	@Override
	public void updateLastLoginTime(User userDB) {
		userMapper.updateLastLoginTime(userDB);
	}

	@Override
	public void resultLoginCount(Integer id) {
		userMapper.resultLoginCount(id);
	}

	@Override
	public void increaseLoginCount(Integer id) {
		userMapper.increaseLoginCount(id);
	}

	@Override
	public void updateErrorCountAndErrorLoginTime(User user) {
		userMapper.updateErrorCountAndErrorLoginTime(user);
	}

    @Override
    public void updateErrorCount(Integer id) {
		userMapper.updateErrorCount(id,new Date());
    }

	@Override
	public void updateErrorTimeCount(Integer id) {
		userMapper.updateErrorTimeCount(id,new Date());
	}

	@Override
	public void resultErrorCount(Integer id) {
		userMapper.resultErrorCount(id);
	}

	@Override
	public void updateErrorStatus(Integer id) {
		userMapper.updateErrorStatus(id,new Date());
	}

	@Override
	public void resultErrorStatus(Integer id) {
		userMapper.resultErrorStatus(id);
	}

	@Override
	public Long findUserListCount(User user) {
		return userMapper.findUserListCount(user);
	}





	@Override
	public void updateAllDept(String ids) {
		if(StringUtils.isNotEmpty(ids)){
			List<Integer> list=new ArrayList<>();
			String[] split = ids.split(",");
			for (String id : split) {
				list.add(Integer.parseInt(id));

			}userMapper.updateAllDept(list);
		}
	}

    @Override
    public void updateAllDeptId(List<Integer> ids, Integer deptId) {
		userMapper.updateAllDeptId(ids,deptId);
    }

	@Override
	public User findUserById(Integer id) {
		User user = userMapper.findUserById(id);
		return user;
	}

	@Override
	public void updateUser(User user) {
		userMapper.updateUser(user);
	}

    @Override
    public List<User> findUserByDeptName(String deptName) {
        List<User> userByDeptName = userMapper.findUserByDeptName(deptName);
        return userByDeptName;
    }


    @Override
	public User queryStatus(Integer id) {
		return userMapper.queryStatus(id);
	}

	@Override
	public void updateErrorStat(Integer id) {
		userMapper.updateErrorStat(id);
	}

    @Override
    public void deleteAll(String ids) {
		if(StringUtils.isNotEmpty(ids)){
			List<Integer> list=new ArrayList<>();
			String[] split = ids.split(",");
			for (String id : split) {
				list.add(Integer.parseInt(id));

			}userMapper.deleteAll(list);
		}
    }

    @Override
    public List<User> queryUserList(User user) {
        return userMapper.queryUserList(user);
    }


}
