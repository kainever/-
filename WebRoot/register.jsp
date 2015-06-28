<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.user.*" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String exception = null;
	String register = request.getParameter("register");
	if(register != null && register.trim().equals("true")) {
		UserService service = UserService.getInstance();
		String username = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		User u = new User();
		u.setName(username);
		u.setPassword(password);
		u.setEmail(email);
		u.setLateOnline(new Timestamp(new java.util.Date().getTime()));
		u.setImgSrc("head.jpg");
		User cu = service.check(username);
		if(cu != null) {
			exception = "用户名已使用..";
		} else {
			try {
				int id = service.save(u);
				u.setId(id);
				session.setAttribute("user", u);
				// 添加自己为好友..
				service.addFriend(u , u);
				response.sendRedirect("home.jsp");
			} catch(FieldNullException e) {
				exception = e.getMessage();
			}
		}
		
	}
%>

<!DOCTYPE html>
<html>
<head>
    <title>
        注册
    </title>
    <meta charset="utf-8">
    <meta charset="utf-8">
    <link href="http://fonts.useso.com/css?family=Lato:100,300,400,700" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.min.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/font-awesome.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
</head>
<body class="login2">
<!-- Signup Screen -->
<div class="login-wrapper">
    <h1 class="">Register</h1>

    <form action="register.jsp" method="post">
    	<input type="hidden" name="register" value="true"/>
    	<%
    		if(exception != null) {
    	%>
    	<p style="color:red"><%=exception %></p>
    	<%
    		}
    	%>
    	<div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-envelope">昵称</i></span><input name="name" class="form-control"
                                                                                           type="text"
                                                                                           placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-envelope">邮箱</i></span><input name="email" class="form-control"
                                                                                           type="text"
                                                                                           placeholder="邮箱地址">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-envelope">密码</i></span><input name= "password" class="form-control"
                                                                                       type="password" placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-ok">确认密码</i></span><input name="password2" class="form-control"
                                                                                     type="password" placeholder="确认密码">
            </div>
        </div>
        <div class="form-group">
            <label class="checkbox text-left col-lg-offset-1"><input type="checkbox"><span>我同意《注册条款》</span></label>
        </div>
        <input class="btn btn-lg btn-primary btn-block" type="submit" value="注册">

        <!-- <div class="social-login clearfix">
            <a class="btn btn-primary pull-left weibo" href="login.html"><i class="icon-weibo"></i>微博 账户登录</a><a
                class="btn btn-primary pull-right renren" href="login.html"><i class="icon-renren"></i>人人 账户登录</a>
        </div> -->
        <p>
            已经有账户了？
        </p>
        <a class="btn btn-default-outline btn-block" href="login.jsp">立即登录</a>
    </form>
</div>
</body>
</html>