<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.user.*"%>
<%@ page import="com.msg.status.*"%>
<%@ page import="com.msg.comment.*"%>
<%
	request.setCharacterEncoding("utf-8");
	User user = (User) session.getAttribute("user");
	if (user == null || user.getName() == null
			|| user.getName().isEmpty()) {
		response.sendRedirect("login.jsp");
		return ;
	}
	UserService service = UserService.getInstance();
	
	if (user.getId() == null) {
		user = service.check(user.getName());
		session.setAttribute("user", user);
		service.getUserFriends(user);
	} else {
		service.getUserFriends(user);
	}
	String p = request.getParameter("page");
	int pageNum = 1;
	if(p != null) {
		pageNum = Integer.parseInt(p.trim());
	}
	StatusService stService = StatusService.getInstance();
	List<Status> listSt = stService.getNewStatus(user , pageNum);
%>

<!-- 在线还得添加online字段 -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>Fixed Top Navbar Example for Bootstrap</title>

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
					<li role="presentation" class="active"><a href="#">Admin <span
							class="badge" style="color:red">42</span></a></li>
					<li role="menuitem"><a href="logout.jsp">注销</a></li>
				</ul>
			</nav>
			<h3 class="text-muted">
				<a href="#"> 留言板 </a>
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
										<a href=""><%=u.getName()%></a>
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
				<div>
					<form role="form" action="#">
						<div class="form-group">
							<textarea class="form-control" rows="3"
								placeholder="今天遇到什么新鲜事，赶紧来吐槽下吧" id="newStatus"></textarea>
						</div>
						<input type="submit" class="btn col-lg-offset-10"
							id="submitStatus" value="publish" style="display: none" />
					</form>
				</div>
				<div class="recentMsg">
					<%
						if (listSt.isEmpty()) {
					%>
					<h3>没有新的动态 , 赶紧添加一个把...</h3>
					<%
						} else {
							Iterator it = listSt.iterator();
							while(it.hasNext()) {
								Status s = (Status) it.next();
					%>
					<div>
						<div class="row">
							<div class="col-lg-2">
								<img class="thumbnail" src="img/<%=s.getUser().getImgSrc() %>"
									style="width: 80px;height: 80px" />
							</div>
							<div class="col-lg-9">
								<h5><%=s.getUser().getName()%></h5>
								<br>

								<p>
									<time>6:25</time>
									<a href="javascript:void(0)" class="col-lg-offset-2 brower"
										onclick="openNew()">浏览(<%=s.getViews() %>)
									</a>
								</p>
							</div>
						</div>
						<div class="content">
							<p class="col-lg-offset-0"><%=s.getContent() %></p>
						</div>

						<div style="background-color: azure" class="allComment">
							<a href="javascript:void(0)" class="col-lg-offset-1 comment">评论(<%=s.getComment_time()%>)
							</a> <a href="javascript:void(0)" class="col-lg-offset-2">赞(<%=s.getPraises() %>)
							</a> <a href="javascript:void(0)" class="col-lg-offset-2">收藏</a>
						</div>
						<%
								if( !s.getComments().isEmpty()) {
									Iterator<Comment> itc = s.getComments().iterator();
										
							%>
						<div class="allComment">
							<ul class="list-group">
								<%
									while(itc.hasNext()) {
										Comment com = itc.next();
										User comUser = com.getUser();
										LinkedList<Comment> coms = com.getComments();
								%>
								<li class="list-group-item">
									<div class="row">
										<div class="col-lg-2">
											<img class="thumbnail" src="img/<%=user.getImgSrc() %>"
												style="width: 50px;height: 50px" />
										</div>
										<div class="col-lg-9">
											<h5><%=user.getName() %>
												:
												<%=com.getContent() %></h5>

											<p>
												<time><%=com.getCommentTime() %></time>
												<a href="javascript:void(0)" class="col-lg-offset-2 comment">回复</a>
											</p>
										</div>
									</div> <%
											if( !coms.isEmpty()) {
												Iterator<Comment> ite = coms.iterator();
													
										%>
									<ul class="list-group">
										<%
												while(ite.hasNext()) {
													Comment sc = ite.next();
													User su = sc.getUser();
											%>
										<li class="list-group-item">
											<div class="row col-lg-offset-1">
												<div class="col-lg-2">
													<img class="thumbnail" src="img\<%=su.getImgSrc() %>"
														style="width: 50px;height: 50px" />
												</div>
												<div class="col-lg-9">
													<h5><%=su.getName() %>评论 : <%=sc.getContent() %>
													</h5>

													<p>
														<time><%=sc.getCommentTime() %></time>
														<a href="javascript:void(0)"
															class="col-lg-offset-2 comment">回复</a>
													</p>
												</div>
											</div>
										</li>
										<%
												}
										%>
									</ul> <%
											}
										%>
								</li>
								<%
									}
								%>
							</ul>
						</div>
						<%
								}
						%>
						<div class="commentS">
							<form role="form" class="form-horizontal">
								<div class="row">
									<div class="col-lg-10">
										<input type="text" class="form-control" id="name"
											placeholder="我也说一句..">
									</div>
									<div class="col-lg-2 col-xs-pull-1">
										<button type="submit" class="btn btn-default form-control">ok</button>
									</div>
								</div>
							</form>
						</div>
						<div class="commentFrame" style="display: none">
							<form role="form" action="ajax">
								<div class="form-group">
									<textarea class="form-control text" rows="3"></textarea>
								</div>
								<input type="submit"
									class="btn btn-primary col-lg-offset-10 submitComment"
									value="发表" />
							</form>
						</div>

					</div>
					<br><hr>
					<%
							}
						}
					%>
				</div>
			</div>

		</div>

		<footer class="footer"
			style="position: absolute; margin-bottom: 1px; width: 100%;">
			<h3 style="font-size: medium;">当前在线人数 100 人</h3>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="application/javascript">
		
		
		
		
		
		
    function show() {
        $("#submitStatus").css("display", "block");
    };
    function comment(event) {
        var commentS = $(event.target).parents(".allComment").siblings(".commentS");
        var commentFrame = commentS.next();
        commentS.hide();
        commentFrame.show();
        var textarea = commentFrame.find(".text");
        textarea.focus();
    };
    function openNew() {
        window.open("http://www.w3school.com.cn", "_blank", "channelmode=yes,titlebar=no,toolbar=no, location=no," +
                " directories=no, status=no, menubar=no, scrollbars=yes, " +
                "resizable=no, copyhistory=no, width=400, height=400");
    };

    function ajaxSubmit() {
        var target = event.target;
        var commentFrame =  target.parents(".commentFrame");
        commentFrame.hide();
        var commentS = commentFrame.siblings(".commentS");
        commentS.show();
    }
    $("#newStatus").click(show);
    //ReferenceError: $ is not defined 也是够坑爹的错误..
    $(".comment").click(comment);
    $(".submitComment").click(ajaxSubmit);

	
	
	
	
	
	</script>
</body>
</html>