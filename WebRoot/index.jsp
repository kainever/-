<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Welcome</title>
	<link rel="stylesheet" href=".\css\bootstrap.min.css">
	<script src=".\js\jquery-1.11.3.js"></script>
	<script src=".\js\bootstrap.min.js"></script>
	<style>
	body{background-image:url("./img/bg.jpg");background-repeat: no-repeat; background-size:cover;}
	h2{font-size:64px; font-family:"΢���ź�";}
	p{font-size:32px; font-family:"����";}
	/*button{text-decoration:none; font-color:#fff; font-family:"΢���ź�"; }*/
	/*button:visited{}*/
	/*button:hover{background-color:#000;}*/
	</style>
	<script>
	function mouseOver(){
		var bg = document.getElementById("btn");
		var content = document.getElementById("content");
		bg.style.backgroundColor = "#000";
		content.style.color="#fff";
	}
	function mouseOut(){
		var bg = document.getElementById("btn");
		var content = document.getElementById("content");
		bg.style.background = "none";
		content.style.color = "#000";
	}
	</script>
</head>
<body>
	<div align="center" style="margin:256px 0">
		<h2>���԰�</h2>
		<h2>��¼����һ��...</h2>
		<button class="btn" id="btn" style="background:none; border:3px solid #000; margin-top:10px" onmouseover="mouseOver()" onmouseout="mouseOut()" onclick="location='login.jsp'"><span id="content" style="font-size:24px">����ʹ��</span></button>
	</div>
</body>
</html>
