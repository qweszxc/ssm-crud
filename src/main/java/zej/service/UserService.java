package zej.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zej.bean.User;
import zej.dao.UserMapper;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;
	
	public boolean loginCheck(User u) {
		User user=userMapper.selectByUserName(u.getUserName());
		if(user==null)return false;
		if(user.getUserPassword().equals(u.getUserPassword()))
			return true;
		else
			return false;
	}
	
	public boolean checkByUserName(String userName) {
		User user=userMapper.selectByUserName(userName);
		if(user==null)
			return true;
		else
			return false;
	}
}
