package zej.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import zej.bean.Student;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/ssm-curd-servlet.xml"})
public class MvcTest {

	//自动装配ioc容器自身，需要注解@WebAppConfiguration
	@Autowired
	WebApplicationContext context;
	//使用spring测试模块测试请求功能
	MockMvc mockMvc;//虚拟mvc请求
	
	//junit的Before
	@Before
	public void initMockMvc() {
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/students")
				.param("pageNum", "1")).andReturn();
		//去除pageInfo验证
		MockHttpServletRequest request=result.getRequest();
		PageInfo page=(PageInfo) request.getAttribute("pageInfo");
		System.out.println(page.getPageNum());
		int[] nums=page.getNavigatepageNums();
		List<Student>students=page.getList();
		for(Student s:students) {
			System.out.println(s.getClasses().getClassesName());
		}
	}
}
