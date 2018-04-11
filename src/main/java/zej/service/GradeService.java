package zej.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zej.bean.Grade;
import zej.dao.GradeMapper;

@Service
public class GradeService {

	@Autowired
	private GradeMapper gradeMapper;
	
	public List<Grade> getGrades(){
		return gradeMapper.selectByExample(null);
	}
}
