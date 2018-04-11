package zej.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import zej.bean.Classes;
import zej.bean.Msg;
import zej.bean.Student;
import zej.service.StudentService;

@Controller
public class StudentController {

	@Autowired
	StudentService studentService;

	// ResponseBody返回json数据，导入jackson包
	@RequestMapping("/students")
	@ResponseBody
	public Msg getStudentWithJson(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
		PageHelper.startPage(pageNum, 5);
		// PageHelper分页插件,startPage方法后面紧跟的查询就是分页查询
		List<Student> students = studentService.getAll();
		// 使用PageInfo包装查询后的结果,只需将PageInfo交给页面
		PageInfo page = new PageInfo(students, 5);// 连续显示5页
		return Msg.success().add("pageInfo", page);
	}
	
	@RequestMapping(value="/students",method=RequestMethod.POST)
	@ResponseBody
	public Msg addStudent(Student student) {
		System.out.println("addStudent");
		studentService.addStudent(student);
		return Msg.success();
	}

	// @RequestMapping("/students")
	public String getStudent(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, Model model) {
		PageHelper.startPage(pageNum, 5);
		// PageHelper分页插件,startPage方法后面紧跟的查询就是分页查询
		List<Student> students = studentService.getAll();
		// 使用PageInfo包装查询后的结果,只需将PageInfo交给页面
		PageInfo page = new PageInfo(students, 5);// 连续显示5页

		model.addAttribute("pageInfo", page);
		return "list";
	}
	
	@RequestMapping("/login")
	@ResponseBody
	public List<Student> login(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
		List<Student> students = studentService.getAll();
		Classes classes=new Classes();
		classes.setClassesId("123");
		List<Classes>m=new ArrayList<>();
		m.add(classes);
		Student s=new Student();
		s.setStudentName("哈哈");
		return students;
	}

	
   
}
