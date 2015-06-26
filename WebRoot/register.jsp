<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

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

    <form>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-envelope"></i></span><input class="form-control"
                                                                                           type="text"
                                                                                           value="请输入您的邮箱地址">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-lock"></i></span><input class="form-control"
                                                                                       type="password" value="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <span class="input-group-addon"><i class="icon-ok"></i></span><input class="form-control"
                                                                                     type="password" value="确认密码">
            </div>
        </div>
        <div class="form-group">
            <label class="checkbox text-left"><input type="checkbox"><span>我同意《注册条款》</span></label>
        </div>
        <input class="btn btn-lg btn-primary btn-block" type="submit" value="注册">

        <div class="social-login clearfix">
            <a class="btn btn-primary pull-left weibo" href="login.html"><i class="icon-weibo"></i>微博 账户登录</a><a
                class="btn btn-primary pull-right renren" href="login.html"><i class="icon-renren"></i>人人 账户登录</a>
        </div>
        <p>
            已经有账户了？
        </p>
        <a class="btn btn-default-outline btn-block" href="login.html">立即登录</a>
    </form>
</div>
<!-- End Signup Screen -->
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>
</html>