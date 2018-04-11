package zej.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zej.bean.Classes;
import zej.bean.GradeExample;
import zej.dao.ClassesMapper;

@Service
public class ClassesService {

	@Autowired
	private ClassesMapper classesMapper;
	
	public List<Classes> getClasses(Integer gradeId){
		GradeExample example=new GradeExample();
		example.createCriteria().andGradeIdEqualTo(gradeId);
		return classesMapper.selectByGradeExample(example);
	}
}
