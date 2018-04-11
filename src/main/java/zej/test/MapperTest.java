package zej.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import zej.bean.Classes;
import zej.bean.ClassesExample;
import zej.bean.Grade;
import zej.bean.GradeExample;
import zej.bean.Student;
import zej.bean.User;
import zej.dao.ClassesMapper;
import zej.dao.GradeMapper;
import zej.dao.StudentMapper;
import zej.dao.UserMapper;

//spring单元测试
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	GradeMapper gradeMapper;
	@Autowired
	ClassesMapper classesMapper;
	@Autowired
	StudentMapper studentMapper;
	@Autowired
	UserMapper userMapper;
	
	@Test
	public void testGrade() {
		Grade g=new Grade();
		g.setGradeId(2016);
		gradeMapper.selectByExample(null);
	}
	
	@Test
	public void testClasses() {
		GradeExample gexample=new GradeExample();
		gexample.createCriteria().andGradeIdEqualTo(2016);
		List<Classes>list=classesMapper.selectByGradeExample(gexample);
		System.out.println(list);
	}
	
	@Test
	public void testStudent() {
		Student student=new Student();
		ClassesExample classesExample=new ClassesExample();
		classesExample.createCriteria().andClassesNameEqualTo("一班");
		List<Student>list=studentMapper.selectByExampleWithClasses(classesExample);
		System.out.println(list);
	}
	
	@Test
	public void testUnionFind() {
		Student student=studentMapper.selectByPrimaryKeyWithClasses(1);
		System.out.println("yes");
		System.out.println(student.getClasses().getClassesName());
	}
	
	@Test
	public void testLazyFind() {
		Student student=studentMapper.lazySelectByPrimaryKey(1);
		System.out.println("yes");
		System.out.println(student.getClasses().getClassesName());
	}
	
	@Test
	public void testFindAll() {
		Student student=studentMapper.selectByPrimaryKeyWithAll(1);
		System.out.println(student.getClasses().getClassesName());
	}
	
	@Test
	public void testUser() {
		User input=new User();
		input.setUserName("test");
		input.setUserEmail("test");
		input.setUserPassword("test");
		userMapper.insert(input);
	}
}
