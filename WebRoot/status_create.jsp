<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.comment.*"%>
<%@ page import="com.msg.user.*"%>
<%@ page import="com.msg.status.*"%>
<%@ page import="java.sql.*"%>


<%
	request.setCharacterEncoding("utf-8");
	Status s = new Status();
	String content = request.getParameter("content");
	s.setContent(content);
	User u = (User)session.getAttribute("user");
	s.setUser(u);
	s.setCreateTime(new Timestamp(new java.util.Date().getTime()));
	
	StatusService ss = StatusService.getInstance();
	int id = ss.insert(s);
	s.setId(id);
	ss.registerNoticeToFriends(u.getFriends() , s);
	
	
	String resp = "<div style='border: 1px solid #e5e5e5'>	"
			+ "<div class='row'>		<div class='col-lg-2'>			"
			+ "<img class='thumbnail' src='img/" + u.getImgSrc()+"'style='width: 80px;height: 80px' />		"
			+ "</div>		<div class='col-lg-9'>			<h5>"+ u.getName() + " </h5>			"
			+ "<br>			<p>				<time>" + s.getCreateTime() + "</time>				"
					+ "<a href='javascript:void(0)' class='col-lg-offset-2 brower'					"
					+ "onclick='openNew()'>浏览(0)				</a>		"
							+ "	</p>		</div>	</div>	<div class='content'>		"
							+ "<p class='col-lg-offset-0'>" + s.getContent() + "</p>	"
									+ "</div>	<div style='background-color: azure' class='allComment'>		"
									+ "<a href='javascript:void(0)' class='col-lg-offset-1 comment' onclick='comment(event)'>评论(0)		"
									+ "</a> <a href='javascript:void(0)' class='col-lg-offset-2'>赞(0)		"
									+ "</a> <a href='javascript:void(0)' class='col-lg-offset-2'>收藏</a>	</div>	"
									+ "<div class='allComment'>	<ul class='list-group biglist'>	</ul> <ul class='list-group'></ul>	</div>	"
									+ "<div class='comment_action'>							<div class='commentS'>								"
									+ "<form role='form' class='form-horizontal'>									"
									+ "<div class='row'>										"
									+ "<div class='col-lg-10'>											"
									+ "<input type='text' class='form-control' id='name' placeholder='我也说一句..'>										"
									+ "</div>					<div class='col-lg-2 col-xs-pull-1'>											"
									+ "<button type='submit' class='btn btn-default form-control'>ok</button>										"
									+ "</div>									</div>								"
									+ "</form>							</div>							"
									+ "<div class='commentFrame' style='display: none'>								"
									+ "<form role='form' action='ajax' class='form'>									"
									+ "<!-- 隐藏表单元素 -->									<input type='hidden' name='comment_id' id='commentId' /> "
									+ "<input										type='hidden' name='p_user_id' id='pUserId' /> "
									+ "<input										type='hidden' name='status_id' value=" + s.getId()+ " /> "
											+ "<input										type='hidden' name='user_id' value='" + u.getId() + "' />									"
													+ "<div class='form-group'>										<textarea class='form-control text' rows='3' name='comment'>"
													+ "</textarea>									</div>									"
													+ "<input type='submit'	class='btn btn-primary col-lg-offset-10 submitComment' value='发表' onclick='ajaxSubmit(event)'/>"
													+ "</form>							</div>						</div> <br><hr>";
													
	out.print(resp);

	
%>

