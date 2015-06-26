<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title></title>

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

		<div class="content">
			<ul class="list-group">
				<li class="list-group-item">
					<div class="row">
						<div class="col-lg-2">
							<img class="thumbnail" style="width: 80px;height: 80px" />
						</div>
						<div class="col-lg-9">
							<h5>UserA �ظ�</h5>
							<br>
							<time>6:25</time>
						</div>
					</div>
					<div class="content">
						<p class="col-lg-offset-0">������һ����������</p>
					</div>
					<div class="allComment">
						<div style="background-color: azure">
							<a href="javascript:void(0)" class="col-lg-offset-1 comment">����(1)</a>
							<a href="javascript:void(0)" class="col-lg-offset-2">��(1)</a> <a
								href="javascript:void(0)" class="col-lg-offset-2">�ղ�</a>
						</div>
						<div class="row">
							<div class="col-lg-2">
								<img class="thumbnail" style="width: 50px;height: 50px" />
							</div>
							<div class="col-lg-9">
								<h5>Admin : �� �ǵģ�</h5>

								<p>
									<time>6:25</time>
									<a href="#" class="col-lg-offset-2">�ظ�</a>
								</p>
							</div>
						</div>
						<div class="row col-lg-offset-1">
							<div class="col-lg-2">
								<img class="thumbnail" style="width: 50px;height: 50px" />
							</div>
							<div class="col-lg-9">
								<h5>UserA�ظ�Admin : �� �ǵģ�</h5>

								<p>
									<time>6:25</time>
									<a href="#" class="col-lg-offset-2">�ظ�</a>
								</p>
							</div>
						</div>
					</div>
					<div class="commentS">
						<form role="form" class="form-horizontal">
							<div class="row">
								<div class="col-lg-10">
									<input type="text" class="form-control" id="name"
										placeholder="��Ҳ˵һ��..">
								</div>
								<div class="col-lg-2 col-xs-pull-1">
									<button type="submit" class="btn btn-default form-control">ok</button>
								</div>
							</div>
						</form>
					</div>
					<div class="commentFrame" style="display: none">
						<form role="form" action="#">
							<div class="form-group">
								<textarea class="form-control text" rows="3"></textarea>
							</div>
							<input type="submit"
								class="btn btn-primary col-lg-offset-10 submitComment"
								value="����" onclick="$" />
						</form>
					</div>
				</li>

				<li class="list-group-item">
					<div class="row">
						<div class="col-lg-2">
							<img class="thumbnail" style="width: 80px;height: 80px" />
						</div>
						<div class="col-lg-9">
							<h5>UserA ����</h5>
							<br>
							<time>6:25</time>
						</div>
					</div>
					<div class="content">
						<p class="col-lg-offset-0">������һ����������</p>
					</div>
					<div class="allComment">
						<div style="background-color: azure">
							<a href="javascript:void(0)" class="col-lg-offset-2 comment">����(1)</a>
							<a href="javascript:void(0)" class="col-lg-offset-2">��(1)</a> <a
								href="javascript:void(0)" class="col-lg-offset-2">�ղ�</a>
						</div>
						<div class="row">
							<div class="col-lg-2">
								<img class="thumbnail" style="width: 50px;height: 50px" />
							</div>
							<div class="col-lg-9">
								<h5>Admin : �� �ǵģ�</h5>

								<p>
									<time>6:25</time>
									<a href="javascript:void(0)" class="col-lg-offset-2 comment">�ظ�</a>
								</p>
							</div>
						</div>
					</div>

					<div class="commentS">
						<form role="form" class="form-horizontal">
							<div class="row">
								<div class="col-lg-10">
									<input type="text" class="form-control" id="name"
										placeholder="��Ҳ˵һ��..">
								</div>
								<div class="col-lg-2 col-xs-pull-1">
									<button type="submit" class="btn btn-default form-control">ok</button>
								</div>
							</div>
						</form>
					</div>
					<div class="commentFrame" style="display: none">
						<form role="form" action="#">
							<div class="form-group">
								<textarea class="form-control text" rows="3"></textarea>
							</div>
							<input type="submit"
								class="btn btn-primary col-lg-offset-10 submitComment"
								value="����" onclick="$" />
						</form>
					</div>
				</li>

			</ul>
		</div>

		<footer class="footer"
			style="position: absolute; margin-bottom: 1px; width: 100%;">
			<h3 style="font-size: medium;">��ǰ�������� 100 ��</h3>
		</footer>
	</div>


	<script src="js/jquery-1.11.3.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="application/javascript">
		
    function show() {
        $("#submit").css("display", "block");
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
    //ReferenceError: $ is not defined Ҳ�ǹ��ӵ��Ĵ���..
    $(".comment").click(comment);

	</script>
</body>
</html>