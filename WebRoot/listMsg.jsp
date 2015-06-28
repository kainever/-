<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.msg.user.*"%>
<%@ page import="com.msg.status.*"%>
<%@ page import="com.msg.comment.*"%>
<%@ page import="com.msg.util.*"%>
<%@ page import="com.msg.notification.*"%>
<%
	//当session失效的时候 ，怎么更新数据到数据库中?
	//session 提供一个接口 .. 开发者实现,session失效后的处理..有吗?
	//实现sessionListener接口..
	request.setCharacterEncoding("utf-8");
	User user = (User) session.getAttribute("user");
	if (user == null || user.getName() == null
	|| user.getName().isEmpty()) {
		response.sendRedirect("login.jsp");
		return ;
	}
	UserService service = UserService.getInstance();
	
	StatusService stService = StatusService.getInstance();
	// 计算留言的数目..
	NoticeService ns = NoticeService.getInstance();
	int msgCount = ns.countStatus(user , true);
	//计算有多少页
	String p = request.getParameter("page");
	int pageCount = 1;
	if(msgCount%Constant.PAGE_SIZE == 0) {
		pageCount = msgCount/Constant.PAGE_SIZE;
	} else {
		pageCount = msgCount/Constant.PAGE_SIZE + 1;
	}
	int pageNum = 1;
	if(p != null) {
		pageNum = Integer.parseInt(p.trim());
		if(pageNum < 1) pageNum = 1;
		if(pageNum > pageCount) pageNum = pageCount;
	}
	
	//更新 用户的刷新时间
	//service.updateOnlineTime();
	//检查当前网站的在线人数
	int online = service.countOnlineNum();
	
	
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

<style>
.hkey {
	display: none;
}
</style>

</head>

<body>

	<div class="container">
		<div class="header clearfix">
			<nav>
				<ul class="nav nav-pills pull-right">
					<li role="presentation" class="active"><a href="listMsg.jsp">Admin
					<% if(msgCount > 0) { %>
					<span class="badge" style="color:red"><%=msgCount %></span>
					<%} %>
					</a></li>
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
										<a href="takeMsg.jsp?id=<%=u.getId()%>"><%=u.getName()%></a>
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
				<%-- <div class="publish_status">
					<form role="form" action="status_create.jsp">
						<div class="form-group">
							<textarea class="form-control" rows="3"
								placeholder="今天遇到什么新鲜事，赶紧来吐槽下吧" id="newStatus" name="content"></textarea>
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
					<div style="border: 1px solid #e5e5e5">
						<div class="row">
							<div class="col-lg-2">
								<img class="thumbnail" src="img/<%=s.getUser().getImgSrc()%>"
									style="width: 80px;height: 80px" />
							</div>
							<div class="col-lg-9">
								<h5><%=s.getUser().getName()%></h5>
								<br>

								<p>
									<time><%=s.getCreateTime()%></time>
									<a href="javascript:void(0)" class="col-lg-offset-2 brower"
										onclick="openNew()">浏览(<%=s.getViews()%>)
									</a>
								</p>
							</div>
						</div>
						<div class="content">
							<p class="col-lg-offset-0"><%=s.getContent()%></p>
						</div>

						<div style="background-color: azure" class="allComment">
							<a href="javascript:void(0)" class="col-lg-offset-1 comment big_comment">评论(<font><%=s.getComment_time()%></font>)
							</a> <a href="javascript:void(0)" class="col-lg-offset-2">赞(<%=s.getPraises()%>)
							</a> <a href="javascript:void(0)" class="col-lg-offset-2">收藏</a>
						</div>
						<%
							
						%>
						<div class="allComment">
							<ul class="list-group biglist">
								<%
									if( !s.getComments().isEmpty()) {
															Iterator<Comment> itc = s.getComments().iterator();
															while(itc.hasNext()) {
																Comment com = itc.next();
																User comUser = com.getUser();
																LinkedList<Comment> coms = com.getComments();
								%>
								<li class="list-group-item" id="<%=com.getId()%>">
									<div class="row">
										<div class="col-lg-2">
											<img class="thumbnail" src="img/<%=comUser.getImgSrc()%>"
												style="width: 50px;height: 50px" />
										</div>
										<div class="col-lg-9">
											<h5><%=comUser.getName()%>:<%=com.getContent()%></h5>
											<p class="hkey"><%=com.getId()%></p>
											<p class="hkey"><%=com.getUser().getId()%></p>
											<p>
												<time><%=com.getCommentTime()%></time>
												<a href="javascript:void(0)"
													class="col-lg-offset-2 comment reply">回复</a>
											</p>
										</div>
									</div>
									<ul class="list-group">
										<%
											if( !coms.isEmpty()) {
												Iterator<Comment> ite = coms.iterator();
										%>
										<%
											while(ite.hasNext()) {
												Comment sc = ite.next();
												User su = sc.getUser();
										%>
										<li class="list-group-item" id="<%=sc.getId()%>">
											<div class="row col-lg-offset-1">
												<div class="col-lg-2">
													<img class="thumbnail" src="img\<%=su.getImgSrc()%>"
														style="width: 50px;height: 50px" />
												</div>
												<div class="col-lg-9">
													<h5><%=su.getName()%>评论
														<%=sc.getpUser().getName()%>:
														<%=sc.getContent()%>
													</h5>

													<p class="hkey"><%=sc.getId()%></p>
													<p class="hkey"><%=sc.getUser().getId()%></p>

													<p>
														<time><%=sc.getCommentTime()%></time>
														<a href="javascript:void(0)"
															class="col-lg-offset-2 comment reply">回复</a>
													</p>
												</div>
											</div>
										</li>
										<%
											}
										%>
										<%
											}
										%>
									</ul>
								</li>
								<%
									}
												
														}
								%>

							</ul>
						</div>
						<div class="comment_action">
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
								<form role="form" action="ajax" class="form">
									<!-- 隐藏表单元素 -->
									<input type="hidden" name="comment_id" id="commentId" /> <input
										type="hidden" name="p_user_id" id="pUserId" /> <input
										type="hidden" name="status_id" value="<%=s.getId()%>" /> <input
										type="hidden" name="user_id" value="<%=user.getId()%>" />
									<div class="form-group">
										<textarea class="form-control text" rows="3" name="comment"></textarea>
									</div>
									<input type="submit"
										class="btn btn-primary col-lg-offset-10 submitComment"
										value="发表" />
								</form>
							</div>
						</div>

					</div>
					<br>
					<hr>
					<%
						}
									}
					%>
				</div>
				<div class="">
					<ul class="pager">
	 					 <li class="previous"><a href="home.jsp?page=<%=pageNum-1%>">&larr; 前一页</a></li>
	  					 <li class="next"><a href="home.jsp?page=<%=pageNum+1%>">下一页 &rarr;</a></li>
					</ul>
				</div>
				 --%>
				 <img src="img/a.jpg" width="600px" />
				
			</div>

		</div>

		<footer class="footer"
			style="position: absolute; margin-bottom: 1px; width: 100%;">
			<h3 style="font-size: medium;">当前在线人数 <font><%=online %><font>人</h3>
		</footer>
	</div>
	<!-- /container -->


	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="application/javascript">
		
		
	/* $(document).ready(function() {
		$(".hkey").hide();
	}); */
		
    function show() {
        $("#submitStatus").css("display", "block");
    };
    
    function comment(event) {
    	 var commentAction = $(event.target).parents(".allComment").siblings(".comment_action");
    	 var commentS = commentAction.find(".commentS");
    	 var commentFrame = commentS.next();
         commentS.hide();
         commentFrame.show();
         var textarea = commentFrame.find(".text");
         textarea.focus();
    	var reply = $(event.target).hasClass("reply");
    	// 填入值 用于表单提交
    	//bug : 
    	var commentId = commentFrame.find("#commentId");
    	var pUserId = commentFrame.find("#pUserId");
    	if(reply) {
    		var hkeyCommentId = $(event.target).parent().siblings(".hkey");
    		var hkeyPUserId = hkeyCommentId.next();
    		commentId.val(hkeyCommentId.html());
    		pUserId.val(hkeyPUserId.html());
    	} else {
    		//记得重置 可能前一次子子评论的值仍在
    		commentId.val("");
    		pUserId.val("");
    	} 
    	
    };
    
    function openNew() {
        window.open("http://www.w3school.com.cn", "_blank", "channelmode=yes,titlebar=no,toolbar=no, location=no," +
                " directories=no, status=no, menubar=no, scrollbars=yes, " +
                "resizable=no, copyhistory=no, width=400, height=400");
    };

   // ajax提交评论 
    function ajaxSubmit(event) {
    	var target = $(event.target);
        var form = target.parent();
        var commentId = target.siblings("input[name='comment_id']");
        var comIdVal = commentId.val();
        /* if(comIdVal == "")
        	alert("yes"); */
        //ajax提交
        var formVals = form.serialize();
        $.ajax({    
	        type:'post',        
	        url:'comment_publish.jsp',    
	        data:formVals,    
	        cache:false,    
	        dataType:'html',    
	        success:function(data){ 
	        	var commentFrame =  target.parents(".commentFrame");
                commentFrame.hide();
                var commentS = commentFrame.siblings(".commentS");
                commentS.show();
                var commentAction = target.parents(".comment_action");
                // 向上查找元素的插入位置
                var ac = commentAction.siblings(".allComment");
                var comContainer = ac.find("ul").eq(0);
                var comAc = ac.find(".big_comment");
                // 分割返回数据 resp 是一个数组！
                var resp = data.split("_");
                var times = resp[0];
                var comment = resp[1];
                //重新设置评论数目
                comAc.children().html(times);
                // 子评论 否则为直接评论 
                if(comIdVal != "") {
                	var tmp = comContainer.find("#" + comIdVal);
                	//子评论的评论
                	if(tmp.parent().hasClass("biglist")) {
                		/* if(ul.length == 0) {
                			tmp.append("<ul class='list-group'> </ul>")
                		} */
                		var ul = tmp.find("ul");
                		tmp.find("ul").append(comment);
                	} else {//子子评论的评论
                		var sonComContainer = tmp.parent();
                		sonComContainer.append(comment);
                	}
                } else {
                	comContainer.append(comment);
                }
	        }    
	    });
        return false;
    }
    
   // 提交动态
    function submitStatus() {
    	var form = $("#submitStatus").parent();
    	 var formVals = form.serialize();
    	 var statusContainer = form.parent().siblings(".recentMsg");
    	 var divs = statusContainer.children();
         $.ajax({    
 	        type:'post',        
 	        url:'status_create.jsp',    
 	        data:formVals,    
 	        cache:false,    
 	        dataType:'html',    
 	        success:function(data){ 
 	        	window.location.reload();
 	        	//$("#submitStatus").hide();
 	        	/* if(divs.length <= 0) {
 	        		statusContainer.append(data);
 	        	} else {
 	        		var div = divs.eq(0);
 	        		div.before(data);
 	        	} */
 	        }    
 	    });
         return false;
    }
    
    
    $("#newStatus").click(show);
    //ReferenceError: $ is not defined 也是够坑爹的错误..
    $(".comment").click(comment);
   $(".submitComment").click(ajaxSubmit);
   $("#submitStatus").click(submitStatus);

	
	
	</script>
</body>
</html>