package zej.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import zej.bean.Classes;
import zej.bean.Msg;
import zej.service.ClassesService;

@Controller
public class ClassesController {

	@Autowired
	private ClassesService classesService;
	
	@RequestMapping("/classes")
	@ResponseBody
	public Msg getClasses(@RequestParam(value = "seletedGrade") Integer gradeId) {
		//@RequestParam(value = "seletedGrade") Integer gradeId
		List<Classes> list=classesService.getClasses(gradeId);
		return Msg.success().add("list", list);
	}
}
