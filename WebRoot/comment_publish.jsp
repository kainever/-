<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.comment.*"%>
<%@ page import="com.msg.user.*"%>
<%@ page import="com.msg.status.*"%>
<%@ page import="java.sql.*"%>


<%
	request.setCharacterEncoding("utf-8");
	Comment com = new Comment();
	String commentId = request.getParameter("comment_id");
	String pUserId = request.getParameter("p_user_id");
	String statusId = request.getParameter("status_id");
	String userId = request.getParameter("user_id");
	// 暂时没考虑是否为空
	if(!commentId.isEmpty() && !pUserId.isEmpty()) {
		Comment c = new  Comment();
		c.setId(Integer.parseInt(commentId));
		User u = new User();
		u.setId(Integer.parseInt(pUserId));
		com.setComment(c);
		com.setpUser(u);
	}
	Status st = new Status();
	st.setId(Integer.parseInt(statusId));
	User u = new User();
	u.setId(Integer.parseInt(userId));
	com.setContent(request.getParameter("comment"));
	com.setStatus(st);
	com.setUser(u);

	CommentService cs = CommentService.getInstance();
	Timestamp t = new Timestamp(new java.util.Date().getTime());
	//将评论插入数据库中
	int id = cs.insert(com);
	//刷新评论的数目 首先找到status
	StatusService stService = StatusService.getInstance();
	Status status = stService.searchById(st.getId());
	int commentTimes = status.getComment_time();
	commentTimes++;
	stService.updateCommentTime(st.getId(), commentTimes);
	
	u = (User) session.getAttribute("user");
	User pUser = null;

	String s = "<li class='list-group-item' id="
			+ id
			+ "> <div class='row'>"
			+ "<div class='col-lg-2'> <img class='thumbnail' src='img/"
			+ u.getImgSrc()
			+ "'"
			+ "style='width: 50px;height: 50px' /> </div>"
			+ " <div class='col-lg-9'> <h5>"
			+ u.getName()
			+ ":"
			+ com.getContent()
			+ "</h5>"
			+ "	<p class='hkey'>"
			+ id
			+ "</p> <p class='hkey'>"
			+ u.getId()
			+ "</p>"
			+ " <p> <time> "
			+ t
			+ "</time> <a href='javascript:void(0)' class='col-lg-offset-2 comment reply' onclick='comment(event)'>回复</a>"
			+ " </p> </div> </div> <ul class='list-group'></ul></li>";
	if(commentId.isEmpty()) {
		 String resp = commentTimes + "_" + s;
		out.print(resp);
	} else {
		UserService us = UserService.getInstance();
		pUser = us.getUserById(Integer.parseInt(pUserId));
		String ss = "<li class='list-group-item' id="
				+ id
				+ "> <div class='row col-lg-offset-1'>"
				+ "<div class='col-lg-2'> <img class='thumbnail' src='img/"
				+ u.getImgSrc()
				+ "'"
				+ "style='width: 50px;height: 50px' /> </div>"
				+ " <div class='col-lg-9'> <h5>"
				+ u.getName()
				+ "评论" + pUser.getName() + " :"
				+ com.getContent()
				+ "</h5>"
				+ "	<p class='hkey'>"
				+ id
				+ "</p> <p class='hkey'>"
				+ u.getId()
				+ "</p>"
				+ " <p> <time> "
				+ t
				+ "</time> <a href='javascript:void(0)' class='col-lg-offset-2 comment reply' onclick='comment(event)'>回复</a>"
				+ " </p> </div> </div> </li>";
	    String resp = commentTimes + "_" + ss;
		out.print(resp);
	}
%>


