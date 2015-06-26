<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
					<li role="menuitem"><a href="logout.jsp">ע��</a></li>
				</ul>
			</nav>
			<h3 class="text-muted">
				<a href="#"> ���԰� </a>
			</h3>
		</div>

		<div class="row">

			<div class="col-lg-3" style="border-right: 1px solid #e5e5e5;">
				<h4>�ҵĺ���</h4>
				<div class="span3 bs-docs-sidebar">
					<ul class="nav nav-list bs-docs-sidenav">
						<li><a href="#dropdowns"><i class="icon-chevron-right"></i>
								�����˵�</a></li>
						<li><a href="#buttonGroups"><i class="icon-chevron-right"></i>
								��ť��</a></li>
						<li><a href="#buttonDropdowns"><i
								class="icon-chevron-right"></i> ��ť�����˵�</a></li>
						<li><a href="#navs"><i class="icon-chevron-right"></i> ����</a></li>
						<li><a href="#navbar"><i class="icon-chevron-right"></i>
								������</a></li>
						<li><a href="#breadcrumbs"><i class="icon-chevron-right"></i>
								���м</a></li>
						<li><a href="#pagination"><i class="icon-chevron-right"></i>
								��ҳ</a></li>
						<li><a href="#labels-badges"><i
								class="icon-chevron-right"></i> ��ǩ�����</a></li>
						<li><a href="#typography"><i class="icon-chevron-right"></i>
								�Ű�</a></li>
						<li><a href="#thumbnails"><i class="icon-chevron-right"></i>
								����ͼ</a></li>
						<li><a href="#alerts"><i class="icon-chevron-right"></i>
								�����</a></li>
						<li><a href="#progress"><i class="icon-chevron-right"></i>
								������</a></li>
						<li><a href="#media"><i class="icon-chevron-right"></i>
								ý�����</a></li>
						<li><a href="#misc"><i class="icon-chevron-right"></i>
								Misc</a></li>
					</ul>
				</div>
			</div>

			<div class="col-lg-9">
				<form role="form" method="post" action="#">
					<label for="msg"><h5>��Admin�����ԣ�</h5></label>
					<textarea class="ckeditor" name="msg"></textarea>
					<button type="submit" class="btn btn-primary pull-right">�ύ</button>
				</form>

			</div>

		</div>


		<footer class="footer"
			style="position: absolute; margin-bottom: 1px; width: 100%;">
			<h3 style="font-size: medium;">��ǰ�������� 100 ��</h3>
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
    ;

    function ajaxSubmit() {
        var target = event.target;
        var commentFrame = target.parents(".commentFrame");
        commentFrame.hide();
        var commentS = commentFrame.siblings(".commentS");
        commentS.show();
    }
    $("#newStatus").click(show);
    //ReferenceError: $ is not defined Ҳ�ǹ��ӵ��Ĵ���..
    $(".comment").click(comment);
    $(".submitComment").click(ajaxSubmit);

	
	</script>
</body>
</html>
