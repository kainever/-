<%@page import="java.sql.Timestamp"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.user.*" %>

<%
	//同时更新在线状态即离线时间
	User u = (User) session.getAttribute("user");
	u.setOnline(false);
	u.setLogoutTime(new Timestamp(new java.util.Date().getTime()));
	UserService us = UserService.getInstance();
	us.updateOnline(u , false);
	//清理会话 
	session.invalidate();
	request.getRequestDispatcher("login.jsp").forward(request, response);
%>

<%-- <jsp:forward page="login.jsp"></jsp:forward> --%>