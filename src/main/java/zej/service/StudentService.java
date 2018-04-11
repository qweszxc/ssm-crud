package zej.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zej.bean.*;
import zej.dao.*;
@Service
public class StudentService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private ClassesMapper classesMapper;

	public List<Student> getAll(){
		
		return studentMapper.selectByExampleWithClasses(null);
	}
	
	public void addStudent(Student student) {
		studentMapper.insert(student);
	}
}
