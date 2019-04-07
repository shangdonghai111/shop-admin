<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/2/17
  Time: 23:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>图片展示</title>
</head>
<body>
<table width="80%">
    <c:forEach items="${imagesList}" var="s" varStatus="status">
        <c:if test="${(status.index+1) % 5== 1}">
            <tr>
        </c:if>
        　　<td ><img width="100px" height="100px" src="<%=request.getContextPath()%>${s.imagePath}">
        </td>
        <c:if test="${(status.index+1) % 5 == 0}">
            </tr>
        </c:if>
    </c:forEach>
</table>
</body>
</html>
