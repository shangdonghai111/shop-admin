<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加商品</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/contextPath.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/shop.js"></script>

</head>
<script type="text/javascript">
$(function(){
	initSelect("option");
	//加载函数里面传给公共的js中的id值 是个字符串  相当于selest的id的值 传给公共的js中
});
$(function(){
	// 添加选项
	$("#opbtn").click(function(){
		if($("#opts>li").size() < 10){// 最多添加6个选项
			$("#opts").append("<li><input type='file' name='filePath'/></li>");
		}else{// 提示选项个数已经达到最大
			$("#optips").html("选项个数已经达到最大,不能再添加!");
			$("#optips").css({"color":"red"});
		}

	});

	// 删除选项
	$("#delbtn").click(function(){
		if($("#opts>li").size() <= 0){
			$("#optips").html("已经没有选项可以删除了!");
			$("#optips").css({"color":"red"});
		} else{
			// 删除选项,每次删除最后一个
			$("#opts>li").last().remove();
		}

	});



});
/************************************************************/
//全局变量，代表文件域的个数，并用该变量区分文件域的name属性
var file_count = 0;
//增加文件 域
function additem(id) {
	if (file_count > 9) {
		alert("最多10个 ");
		return;
	}
	//定义行变量row；单元格变量cell；单元格内容变量str。
	var row, cell, str;
	//在指定id的table中插入一行
	row = eval("document.all[" + '"' + id + '"' + "]").insertRow();
	if (row != null) {
		//设置行的背景颜色
		row.bgColor = "white";
		//在行中插入单元格
		cell = row.insertCell();
		//设置str的值，包括一个文件域和一个删除按钮
		str = '<input onselectstart="return false" class="tf" onpaste="return false" type="file" name="filePath[' + file_count + ']" style="width:500px" onkeydown="return false;"/>';
		str += " <input type=" + '"' + "button" + '"' + " value=" + '"' + "删除" + '"' + " onclick='deleteitem(this," + '"' + "tb" + '"' + ");'>";
		//文件域个数增加
		file_count++;
		//设置单元格的innerHTML为str的内容
		cell.innerHTML = str;
	}
}
//删除文件域
function deleteitem(obj, id) {
	var rowNum, curRow;
	curRow = obj.parentNode.parentNode;
	rowNum = eval("document.all." + id).rows.length - 1;
	eval("document.all[" + '"' + id + '"' + "]").deleteRow(curRow.rowIndex);
	file_count--;
}
</script>
<style>
	*{
		margin: 0px;
		padding: 0px;
	}

	#dv{
		width: 100px;
		height: 100px;
		background-color: yellow;
		margin: 0px auto 0px;
	}

</style>

<body>
	<form action="<%=request.getContextPath()%>/product/add.jhtml" method="post" enctype="multipart/form-data">

		商品名称：<input name="productName"/></br>
		商品价格：<input name="productPrice"/></br>
		商品图片：
	<%--	<input id="inputs" type="file" name="filePath"/>--%>
		<%--<input type=button value="增加" onclick='additem("tb")' />
		<table cellspacing="0" id="tb" style="width:50px">
		</table>--%>
		<div style="margin: 50px;">
			<input id="opbtn" type="button" value="添加选项"/>
			<input id="delbtn" type="button" value="删除选项"/>
			<ol id="opts" type="A"></ol>

			<!-- 提示语 -->
			<span id="optips"></span>
		</div>
		</br>
		品牌名字：
		<select id="option" name="brand.id">
			<option value="-1">---请选择---</option>
			<%-- <c:forEach items="${queryList}" var="aa">
				<option value="${aa.id}">---${aa.brandName}---</option>
			</c:forEach> --%>
		</select>
		<input type="submit">
		<input type="reset"/>
	</form>
</body>

</html>