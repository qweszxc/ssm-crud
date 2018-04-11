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
				<button class="btn btn-primary">增加</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>id</th>
						<th>name</th>
						<th>sex</th>
						<th>age</th>
						<th>class</th>
						<th>grade</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="student">
						<tr>
							<th>${student.studentId }</th>
							<th>${student.studentName }</th>
							<th>${student.studentSex }</th>
							<th>${student.studentAge }</th>
							<th>${student.classes.classesName }</th>
							<th>1</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
								</button>
							</th>
						</tr>
					</c:forEach>
					
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum }页，总共${pageInfo.pages }页，总共${pageInfo.total }条记录
			</div>
			<!-- 分页组件 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	
				  	<li>
				  		<a href="${APP_PATH }/students?pageNum=1">首页</a>
				  	</li>
				  	<c:if test="${pageInfo.hasPreviousPage }">
				  		<li>
					      <a href="${APP_PATH }/students?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				  	</c:if>
				  	<c:if test="${pageInfo.isFirstPage }">
				  		<li class="disabled">
				  			<a href="#" aria-label="Previous">
				  				<span aria-hidden="true">&laquo;</span>
				  			</a>
				  		</li>
				  	</c:if>
				  	
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
				    	<c:if test="${page_Num==pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num!=pageInfo.pageNum }">
				    		<li><a href="${APP_PATH }/students?pageNum=${page_Num}">${page_Num }</a></li>
				    	</c:if>
				    	
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage }">
				  		<li>
					      <a href="${APP_PATH }/students?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
				  	</c:if>
				  	<c:if test="${pageInfo.isLastPage }">
				  		<li class="disabled">
				  			<a href="#" aria-label="Next">
					        	<span aria-hidden="true">&raquo;</span>
					      </a>
				  		</li>
				  	</c:if>
				    
				    <li>
				  		<a href="${APP_PATH }/students?pageNum=${pageInfo.pages}">尾页</a>
				  	</li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
	
</body>
</html>