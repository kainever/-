<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<%
	session.invalidate();
	request.getRequestDispatcher("login.jsp").forward(request, response);
%>

<%-- <jsp:forward page="login.jsp"></jsp:forward> --%>