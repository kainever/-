<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.user.*"%>
<%@ page import="com.msg.status.*"%>
<%@ page import="com.msg.notification.*"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
	User user = (User) session.getAttribute("user");
	if(user == null) {
		response.sendRedirect("login.jsp");
		return ;
	}
	String ids = request.getParameter("id");
	String takeMsg = request.getParameter("takeMsg");
	int id = 0;
	if(ids != null) {
		id = Integer.parseInt(ids);
	}
	UserService service = UserService.getInstance();
	int online = service.countOnlineNum();
	User destUser = null;
	NoticeService ns = NoticeService.getInstance();
	int msgNum = ns.countStatus(user , true);
	// 提交留言
	if(takeMsg != null && takeMsg.equals("true")) {
		String destIds = request.getParameter("destId");
		id = Integer.parseInt(destIds);
		Status st = new Status();
		st.setUser(user);
		st.setContent(request.getParameter("msg"));
		st.setCreateTime(new Timestamp(new java.util.Date().getTime()));
		st.setFriendId(id);
		st.setPraises(0);
		st.setViews(0);
		StatusService ss = StatusService.getInstance();
		//插入
		int sid = ss.insert(st);
		st.setId(sid);
		//注册
		Set<User> fs = new HashSet<User>();
		User du = new User();
		du.setId(id);
		fs.add(du);
		ss.registerNoticeToFriends(fs, st , true);
		/* request.getRequestDispatcher("takeMsg_success.jsp").forward(request, response); */
	} else if(ids != null ) {
		Set<User> us = user.getFriends();
		Iterator itu = us.iterator();
		while(itu.hasNext()) {
			User u = (User)itu.next();
			if(u.getId() == id) {
				destUser = u;
				break;
			}
		}
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<%
	if(destUser != null) {
%>
<title>给<%=destUser.getName()%>留言
</title>
<%
	} else {
%>
<title>留言框</title>
<%
	}
%>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/jumbotron-narrow.css" rel="stylesheet">



</head>

<body>

	<div class="container">
		<div class="header clearfix">
			<nav>
				<ul class="nav nav-pills pull-right">
					<li role="presentation" class="active"><a href="listMsg.jsp"><%=user.getName()%>
					<% if(msgNum > 0) { %>
					<span class="badge" style="color:red"><%=msgNum %></span>
					<%} %></a></li>
					<li role="menuitem"><a href="logout.jsp">注销</a></li>
				</ul>
			</nav>
			<h3 class="text-muted">
				<a href="home.jsp"> 留言板 </a>
			</h3>
		</div>

		<div class="row">

			<div class="col-lg-3" style="border-right: 1px solid #e5e5e5;">
				<h4>我的好友</h4>

				<div class="span3 bs-docs-sidebar">
					<ul class="nav nav-list bs-docs-sidenav">
						<%
							if (user.getFriends().isEmpty()) {
						%>
						<h3>你还没有朋友了....</h3>
						<%
							} else {
																Iterator it = user.getFriends().iterator();
																while (it.hasNext()) {
																	User u = (User) it.next();
						%>
						<li>
							<div class="row">
								<div class="col-lg-3">
									<img class="thumbnail" src="img/<%=u.getImgSrc()%>"
										style="width: 50px;height: 50px" />
								</div>
								<div class="col-lg-8 col-lg-offset-1">
									<h5>
										<a href="takeMsg.jsp?<%=u.getId()%>"><%=u.getName()%></a>
									</h5>
									<br>
								</div>
							</div>
						</li>
						<%
							}
															}
						%>
					</ul>
				</div>
			</div>

			<div class="col-lg-9">
				<form role="form" method="post" action="javascript:void(0)">
					<label for="msg"><h5>
							<%
								if(destUser != null) {
							%>
							给<%=destUser.getName()%>留言
							<%
								} else {
							%>
							给好友留言吧...
							<%
								}
							%>
							</h5>
						</label> <input type="hidden" name="destId" value="<%=id%>"> <input
						type="hidden" name="takeMsg" value="true">
					<textarea class="ckeditor" name="msg"></textarea>
					<button type="submit" class="btn btn-primary pull-right" id="msgSubmit">提交</button>
				</form>

			</div>

		</div>


		<footer class="footer"
			style="position: absolute; margin-bottom: 1px; width: 100%;">
			<h3 style="font-size: medium;">
				当前在线人数 <font><%=online%></font>人
			</h3>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="ckeditor/ckeditor.js"></script>
	<script src="js/sample.js" type="text/javascript"></script>

	<script type="application/javascript">
		
		
	/* 	
    function show() {
        $("#submitStatus").css("display", "block");
    }
    ;
    function comment(event) {
        var commentS = $(event.target).parents(".allComment").siblings(".commentS");
        var commentFrame = commentS.next();
        commentS.hide();
        commentFrame.show();
        var textarea = commentFrame.find(".text");
        textarea.focus();
    }
    ;
    function openNew() {
        window.open("http://www.w3school.com.cn", "_blank", "channelmode=yes,titlebar=no,toolbar=no, location=no," +
                " directories=no, status=no, menubar=no, scrollbars=yes, " +
                "resizable=no, copyhistory=no, width=400, height=400");
    }
    ; */

    function ajaxSubmit() {
    	var form = $("#msgSubmit").parent().serialize();
    	$.ajax({    
 	        type:'post',        
 	        url:'takeMsg.jsp',    
 			data : form,
 	        cache:false,    
 	        dataType:'html',    
 	        success:function(data){ 
 	        	alert("ok");
 	            window.location.reload();
 	        }    
 	    });
         return false;
    }
   /*  $("#newStatus").click(show);
    //ReferenceError: $ is not defined 也是够坑爹的错误..
    $(".comment").click(comment); */
    $("#msgSubmit").click(ajaxSubmit);

	
	
	</script>
</body>
</html>
