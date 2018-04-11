<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());//项目路径，以/开始但没有以/结束
%>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/jq/jquery-3.3.1.min.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">注册</h4>
      </div>
      <div class="modal-body">
        
        <form class="form-horizontal">
	        
		  <div class="form-group" >
		    <label for="register_user_name" class="col-md-2">用户名</label>
		    <div class="col-md-8">
		    	<input type="text" name="registerUserName" class="form-control" id="register_user_name" >
		    	<span id="helpBlock1" class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="register_user_email" class="col-md-2">邮箱</label>
		    <div class="col-md-8">
		    	<input type="text" name="registerUserName" class="form-control" id="register_user_email" >
		  		<span id="helpBlock2" class="help-block"></span>
		  	</div>
		  </div>
		  <div class="form-group">
		    <label for="register_user_password" class="col-md-2">密码</label>
		    <div class="col-md-8">
		    	<input type="password" name="registerUserPassword" class="form-control" id="register_user_password" >
		  		<span id="helpBlock3" class="help-block"></span>
		  	</div>
		  </div>
		  <div class="form-group">
		    <label for="confirm_user_password" class="col-md-2">再次确认密码</label>
		    <div class="col-md-8">
		    	<input type="password" name="confirmUserPassword" class="form-control" id="confirm_user_password" >
		  		<span id="helpBlock4" class="help-block"></span>
		  	</div>
		  </div>
		</form>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" id="register_button" class="btn btn-primary">注册</button>
      </div>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-md-12 text-center">
  	<h1>登录</h1>
  </div>
</div>
<div class="row">
  <form id="login_form" class="col-md-4 col-md-offset-4">
	  <div class="form-group">
	    <label for="user_name">用户名</label>
	    <input type="text" name="userName" class="form-control" id="user_name" >
	  </div>
	  <div class="form-group">
	    <label for="user_password">密码</label>
	    <input type="password" name="userPassword" class="form-control" id="user_password" >
	  </div>
	  <div class="col-md-4 col-md-offset-8">
	  	<button type="button" id="login_button" class="btn btn-primary">登录</button>
	  	<button type="button" id="register" class="btn btn-default" data-toggle="modal">注册</button>
	  </div>
	</form>
</div>
<script type="text/javascript">
	$("#register").click(function(){
		$("#registerModal form")[0].reset();
		$("#registerModal").modal({
			backdrop:"static"
		});
	});
	
	$("#login_button").click(function(){
		$.ajax({
			url:"${APP_PATH}/login",
			type:"POST",
			data:$("#login_form").serialize(),
			success:function(result){
				if(result.code==200){
					alert(result.msg);
				}else{
					window.location.href="${APP_PATH}/index.jsp";
				}
			}
		});
	});
	
	function show_validate_msg(ele,status,msg){
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if ("success" == status) {
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text("");
		} else if ("error" == status) {
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}
	
	$("#register_user_name").change(function(){
		$("#register_user_name").next("span").text("");
		$.ajax({
			url:"${APP_PATH}/check",
			data:"userName="+this.value,
			type:"POST",
			success:function(result){
				if(result.code==100){
					show_validate_msg("#register_user_name","success","");
					$("#register_button").attr("ajax-validate","success");
				}else{
					show_validate_msg("#register_user_name","error","用户名不可用");
					$("#register_button").attr("ajax-validate","error");
				}
			}
		});
	});
	
	$("#register_button").click(function(){
		var status=$("#register_button").attr("ajax-validate");
		if(status=="error"){
			alert("error");
			return;
		}
	});
	
</script>
</body>
</html>