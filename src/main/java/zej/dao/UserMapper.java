package zej.dao;

import zej.bean.User;

public interface UserMapper {

	void insert(User u);
	
	User selectByUserName(String userName);
	
	User selectByEmail(String userEmail);
}
