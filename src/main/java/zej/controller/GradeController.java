package zej.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import zej.bean.Grade;
import zej.bean.Msg;
import zej.service.GradeService;

@Controller
public class GradeController {

	@Autowired
	private GradeService gradeService;
	
	@RequestMapping("/grades")
	@ResponseBody
	public Msg getGrades() {
		List<Grade>list=gradeService.getGrades();
		return Msg.success().add("grades", list);
	}
	
}
