<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <script type="javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-1.11.3.min.js"></script>
    <script type="javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/font-awesome.min.css"/>
    <style type="text/css">


    </style>
</head>
<body>

<center>
    <table height="400"  width="300px" cellspacing="0">
        <tr>
            <td>
                <font size="5">尊敬的会员 </font>
                <font style="size:20px;color: red">${sessionScope.user.userName}</font><font >您好!</font>
            </td>
        </tr>
        <tr>
            <td>您今天登陆了
                <font style="size:20px;color: red">${sessionScope.user.count}</font>次</td>
        </tr>
        <tr>
            <td>上次登陆时间为:</td>
        </tr>
        <tr>
            <td>
                <font style="size:20px;color: red">
                    <f:formatDate  value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss" type="date"></f:formatDate>
                </font>
            </td>
        </tr>
        <tr>
            <td><a href="<%=request.getContextPath()%>/product/queryList.jhtml">商品查询</a></td>
        </tr>
        <tr>
            <td><a href="<%=request.getContextPath()%>/brand/query.jhtml">品牌查询</a></td>
        </tr>

    </table>
</center>
</body>
</html>