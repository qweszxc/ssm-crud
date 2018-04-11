package zej.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import zej.bean.Msg;
import zej.bean.User;
import zej.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	@ResponseBody
	public Msg login(User u) {
		if(userService.loginCheck(u))
			return Msg.success().add("user", u);
		else
			return Msg.fail();
	}
	
	@RequestMapping(value="/check")
	@ResponseBody
	public Msg checkByUserName(@RequestParam(value="userName")String userName) {
		if(userService.checkByUserName(userName))
			return Msg.success();
		else
			return Msg.fail();
	}
}
