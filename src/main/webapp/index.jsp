<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 不以/开始的相对路径，找资源，以当前资源的路径为基准，容易出问题
	以/开始的路径，找资源，以服务器的路径为标准：http://localhost:8080/,所以要加上项目名
 -->

<title>学生列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());//项目路径，以/开始但没有以/结束
%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/jq/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">添加学生</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="student_name_input" class="col-sm-2 control-label">学生姓名</label>
			    <div class="col-sm-10">
			      <input type="text" name="studentName" class="form-control" id="student_name_input" placeholder="学生姓名">
			    </div>
			  </div>
			  
			  <div class="form-group">
			  	<label for="sex" class="col-sm-2 control-label">性别</label>
			  	<div class="col-sm-4">
				    <label class="radio-inline">
					  <input type="radio" name="studentSex" id="sex" value="男" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="studentSex" id="sex" value="女"> 女
					</label>
				</div>
				<label for="student_age" class="col-sm-2 control-label">年龄</label>
				<div class="col-sm-4">
				    <select class="form-control" name="studentAge" id="age_select">
				    	<option selected="selected">17</option>
				    	<option >18</option>
				    	<option >19</option>
				    	<option >20</option>
					</select>
				</div>
			  </div>
			  
			  <div class="form-group">
			  	<label class="col-sm-2 control-label">年级</label>
			  		<div class="col-sm-4">
					    <select class="form-control" name="grade" id="grade_select">
						</select>
					</div>
			  </div>
			  
			  <div class="form-group">
			  	<label class="col-sm-2 control-label">班级</label>
			  	<div class="col-sm-4">
				    <select class="form-control" name="classesId" id="classes_select">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="add_button">确定</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 添加 -->
	
	
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>学生信息列表</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id="student_add_button" data-toggle="modal" >增加</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="students_table">
					<thead>
						<tr>
							<th>id</th>
							<th>name</th>
							<th>sex</th>
							<th>age</th>
							<th>class</th>
							<th>grade</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info">
				
			</div>
			<!-- 分页组件 -->
			<div class="col-md-6" id="page_nav">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//页面加载完成后发送ajax请求，得到分页数据
		$(function(){
			to_page(1);
		})
		
		function to_page(page_Num){
			$.ajax({
				url:"${APP_PATH}/students",
				data:"pageNum="+page_Num,
				type:"GET",
				success:function(result){
					//console.log(result);
					//解析并显示数据
					build_students_table(result);
					//解析并显示分页数据
					build_page_info(result);
					build_page_nav(result);
				}
			})
		}
		function build_students_table(result){
			//清空
			$("#students_table tbody").empty();
			var students=result.extend.pageInfo.list;
			$.each(students,function(index,item){
				//alert(item.studentName);
				var studentIdTd=$("<td></td>").append(item.studentId);
				var studentNameTd=$("<td></td>").append(item.studentName);
				var studentSexTd=$("<td></td>").append(item.studentSex);
				var studentAge=$("<td></td>").append(item.studentAge);
				var studentClassesTd=$("<td></td>").append(item.classes.classesName);
				var studentGradeTd=$("<td></td>").append(item.classes.gradeId);
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
				var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-sm")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(deleteBtn);
				$("<tr></tr>").append(studentIdTd)
					.append(studentNameTd)
					.append(studentSexTd)
					.append(studentAge)
					.append(studentClassesTd)
					.append(studentGradeTd)
					.append(btnTd)
					.appendTo("#students_table tbody");
			})
		}
		function build_page_info(result){
			$("#page_info").empty();
			$("#page_info").append("当前"+result.extend.pageInfo.pageNum+"页，总共"+
					result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+"条记录");
		}
		function build_page_nav(result){
			$("#page_nav").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
			
			
			
			
			if(!result.extend.pageInfo.hasPreviousPage){
				prePageLi.addClass("disabled");
				firstPageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1);
				})
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				})
			}
			if(!result.extend.pageInfo.hasNextPage){
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
				
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				})
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				})
			}
			ul.append(firstPageLi).append(prePageLi);
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(item==result.extend.pageInfo.pageNum)
					numLi.addClass("active");
				numLi.click(function(){
					to_page(item);
				})
				ul.append(numLi);
			})
			ul.append(nextPageLi).append(lastPageLi);
			
			var nav=$("<nav></nav>").append(ul);
			nav.appendTo("#page_nav");
		}
		
		$("#student_add_button").click(function(){
			$("#grade_select").empty();
			getGrades("#grade_select");
			$("#addModal").modal({
				backdrop:"static"
			});
			
		});
		
		function getGrades(ele){
			$.ajax({
				url:"${APP_PATH}/grades",
				type:"GET",
				success:function(result){
					//console.log(result);
					$("<option></option>").appendTo(ele);
					$.each(result.extend.grades,function(index,item){
						var optionEle=$("<option></option>")
							.append(item.gradeId).attr("value",item.gradeId);
						if(index==0){
							optionEle.prop("seleted",true);
						}
						optionEle.appendTo(ele);
						
					});
				}
			});
		}
		
		$("#grade_select").change(function(){
			var index=document.getElementById("grade_select").selectedIndex;
			if(index!=0){
			var seletedGrade=$("#grade_select option:selected").text();
			//console.log("yes"+index);
			$.ajax({
				url:"${APP_PATH}/classes",
				data:"seletedGrade="+seletedGrade,
				type:"GET",
				success:function(result){
					$("#classes_select").empty();
					$("<option></option>").appendTo("#classes_select");
					$.each(result.extend.list,function(index,item){
						var optionEle=$("<option></option>")
							.append(item.classesName).attr("value",item.classesId);//取值为班级id
						optionEle.appendTo("#classes_select");
					});
				}
			});
			}else{
				console.log("no"+index);
			}
		});
		
		$("#add_button").click(function(){
			if(!validate_add_form()){
				return false;
			}
			$.ajax({
				url:"${APP_PATH}/students",
				type:"POST",
				data:$("#addModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					$("#addModal").modal('hide');
				}
			});
		})
		
		function validate_add_form(){
			var studentName=$("#student_name_input").val();
			var regName=/^[\u4e00-\u9fa5]{1,}$/;
			//alert(regName.test(studentName));
			if(!regName.test(studentName)){
				alert("姓名为空")
				return false;
			}
			var classesName=$("#classes_select").val();
			if(classesName==null||classesName==""){
				alert("班级为空");
				return false;
			}
			var grade=$("#grade_select").val();
			if(grade==null||grade==""){
				alert("年级为空");
				return false;
			}
			alert("true");
			return false;
		}
		
		
		
	</script>
</body>
</html>