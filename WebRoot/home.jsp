<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

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
                <li role="presentation" class="active"><a href="#">Admin <span class="badge" style="color:red">42</span></a></li>
                 <li role="menuitem"><a href="logout.jsp">ע��</a></li>
            </ul>
        </nav>
        <h3 class="text-muted"><a href="#"> ���԰� </a></h3>
    </div>

    <div class="row">

        <div class="col-lg-3" style="border-right: 1px solid #e5e5e5;">
            <h4>�ҵĺ���</h4>

            <div class="span3 bs-docs-sidebar">
                <ul class="nav nav-list bs-docs-sidenav">
                    <li><a href="#dropdowns"><i class="icon-chevron-right"></i> �����˵�</a></li>
                    <li><a href="#buttonGroups"><i class="icon-chevron-right"></i> ��ť��</a></li>
                    <li><a href="#buttonDropdowns"><i class="icon-chevron-right"></i> ��ť�����˵�</a></li>
                    <li><a href="#navs"><i class="icon-chevron-right"></i> ����</a></li>
                    <li><a href="#navbar"><i class="icon-chevron-right"></i> ������</a></li>
                    <li><a href="#breadcrumbs"><i class="icon-chevron-right"></i> ���м</a></li>
                    <li><a href="#pagination"><i class="icon-chevron-right"></i> ��ҳ</a></li>
                    <li><a href="#labels-badges"><i class="icon-chevron-right"></i> ��ǩ�����</a></li>
                    <li><a href="#typography"><i class="icon-chevron-right"></i> �Ű�</a></li>
                    <li><a href="#thumbnails"><i class="icon-chevron-right"></i> ����ͼ</a></li>
                    <li><a href="#alerts"><i class="icon-chevron-right"></i> �����</a></li>
                    <li><a href="#progress"><i class="icon-chevron-right"></i> ������</a></li>
                    <li><a href="#media"><i class="icon-chevron-right"></i> ý�����</a></li>
                    <li><a href="#misc"><i class="icon-chevron-right"></i> Misc</a></li>
                </ul>
            </div>
        </div>

        <div class="col-lg-9">
            <div>
                <form role="form" action="#">
                    <div class="form-group">
                        <textarea class="form-control" rows="3" placeholder="��������ʲô�����£��Ͻ����²��°�"
                                 id="newStatus"></textarea>
                    </div>
                    <input type="submit" class="btn col-lg-offset-10" id="submitStatus" value="publish"
                           style="display: none"/>
                </form>
            </div>
            <div class="recentMsg">
                <div class="row">
                    <div class="col-lg-2">
                        <img class="thumbnail" style="width: 80px;height: 80px"/>
                    </div>
                    <div class="col-lg-9">
                        <h5>UserA</h5><br>

                        <p>
                            <time>6:25</time>
                            <a href="javascript:void(0)" class="col-lg-offset-2 brower"
                               onclick="openNew()">���(1)</a></p>
                    </div>
                </div>
                <div class="content">
                    <p class="col-lg-offset-0">������һ����������</p>
                </div>

                <div class="allComment">
                    <div style="background-color: azure">
                        <a href="javascript:void(0)" class="col-lg-offset-1 comment">����(1)</a>
                        <a href="javascript:void(0)" class="col-lg-offset-2">��(1)</a>
                        <a href="javascript:void(0)" class="col-lg-offset-2">�ղ�</a>
                    </div>
                    <div class="allComment">
                        <ul class="list-group">
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <img class="thumbnail" style="width: 50px;height: 50px"/>
                                    </div>
                                    <div class="col-lg-9">
                                        <h5>Admin : �� �ǵģ�</h5>

                                        <p>
                                            <time>6:25</time>
                                            <a href="javascript:void(0)" class="col-lg-offset-2 comment">�ظ�</a></p>
                                    </div>
                                </div>
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <div class="row col-lg-offset-1">
                                            <div class="col-lg-2">
                                                <img class="thumbnail" style="width: 50px;height: 50px"/>
                                            </div>
                                            <div class="col-lg-9">
                                                <h5>Admin2�ظ�Admin : �� �ǵģ�</h5>

                                                <p>
                                                    <time>6:25</time>
                                                    <a href="javascript:void(0)" class="col-lg-offset-2 comment">�ظ�</a></p>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="row col-lg-offset-1">
                                            <div class="col-lg-2">
                                                <img class="thumbnail" style="width: 50px;height: 50px"/>
                                            </div>
                                            <div class="col-lg-9">
                                                <h5>Admin�ظ�Admin2 : ����������</h5>

                                                <p>
                                                    <time>6:25</time>
                                                    <a href="javascript:void(0)" class="col-lg-offset-2 comment">�ظ�</a></p>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                            <li class="list-group-item">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <img class="thumbnail" style="width: 50px;height: 50px"/>
                                    </div>
                                    <div class="col-lg-9">
                                        <h5>Admin3 : ��ȷ��</h5>

                                        <p>
                                            <time>6:25</time>
                                            <a href="javascript:void(0)" class="col-lg-offset-2 comment">�ظ�</a></p>
                                    </div>
                                </div>
                            </li>
                        </ul>
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
                    <form role="form" action="ajax">
                        <div class="form-group">
                            <textarea class="form-control text" rows="3"></textarea>
                        </div>
                        <input type="submit" class="btn btn-primary col-lg-offset-10 submitComment" value="����"
                               />
                    </form>
                </div>

            </div>
        </div>

    </div>

    <footer class="footer" style="position: absolute; margin-bottom: 1px; width: 100%;">
        <h3 style="font-size: medium;">��ǰ�������� 100 ��</h3>
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
    //ReferenceError: $ is not defined Ҳ�ǹ��ӵ��Ĵ���..
    $(".comment").click(comment);
    $(".submitComment").click(ajaxSubmit);
</script>
</body>
</html>