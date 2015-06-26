<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html>
<html>
<head>
    <title>
        login
    </title>
    <meta charset="utf-8">
    <link href="http://fonts.useso.com/css?family=Lato:100,300,400,700" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.min.css" media="all" rel="stylesheet" type="text/css"/>
   <link href="css/font-awesome.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="js/jquery-1.11.3.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <style>
        body {
            min-height: 2000px;
            padding-top: 70px;
        }
    </style>
</head>
<body class="login2">
<!-- Login Screen -->
<div class="login-wrapper">
    <br><br>
    <center><h1>Login</h1></center>

    <form action="login.html">
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-envelope"></i></span><input class="form-control"
                                                                                           placeholder="用户名/邮箱"
                                                                                           type="text">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-lock"></i></span><input class="form-control"
                                                                                       placeholder="密码" type="text">
            </div>
        </div>
        <a class="pull-right" href="#">忘记密码了？</a>

        <div class="pull-left">
            <label class="checkbox"><input type="checkbox"><span>自动登录</span></label>
        </div>
        <input class="btn btn-lg btn-primary btn-block" type="submit" value="登录">

        <div class="social-login clearfix">
            <a class="btn btn-primary pull-left weibo" href="login.html"><i class="icon-weibo"></i>微博 账户登录</a><a
                class="btn btn-primary pull-right renren" href="login.html"><i class="icon-renren"></i>人人 账户登录</a>
        </div>
    </form>
    <p>
        还没有账户？
    </p>
    <a class="btn btn-default-outline btn-block" href="register.html">立即注册</a>
</div>
<!-- End Login Screen -->
<!--<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>-->
</body>
</html>