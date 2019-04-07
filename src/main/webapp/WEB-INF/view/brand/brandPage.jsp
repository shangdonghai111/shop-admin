<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link href="<%=request.getContextPath() %>/commons/datatable/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet"
<script type="text/javascript" src="<%=request.getContextPath() %>/commons/datatable/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/commons/datatable/DataTables-1.10.18/js/dataTables.bootstrap.min.js"></script>
<c:if test="${!empty list }">
<table border="1" cellspacing="0" width="1000" id="ziTr">
<thead>
		<tr>
			<td>序号</td>
			<td>品牌名字</td>
			<td>
			<input type="button" value="↑" data-sort-field="entrtyTime" data-sort="asc"/>
			录入时间
			<input type="button" value="↓" data-sort-field="entrtyTime" data-sort="desc"/>
			</td>
			<td>
			<input type="button" value="↑" data-sort-field="updateTime" data-sort="asc"/>
			修改时间
			<input type="button" value="↓" data-sort-field="updateTime" data-sort="desc"/>
			</td>
			<td>操作</td>
		</tr>
</thead>
<tbody>
		<c:forEach items="${list}" var="bean">
			<tr>
			<td>
			<input type="checkbox" name="checkName" value="${bean.id}">
			${bean.id}</td>
			<td data-id="${bean.id}" data-brandName="${bean.brandName}">
			${bean.brandName}
			</td>
			<td>
			<fmt:formatDate value='${bean.entrtyTime}' pattern='yyyy-MM-dd HH:mm:ss' type='date'/>
			</td>
			<td>
			<fmt:formatDate value='${bean.updateTime}' pattern='yyyy-MM-dd HH:mm:ss' type='date'/>
			</td>
			<td>
			<input type="button" value="修改" onclick="findOne('${bean.id}')"/>
			<input type="button" value="删除" onclick="deleteOne('${bean.id}')"/>
			<input type="button" value="编辑" onclick="findBrand('${bean.id}')"/>
			</td>
		</tr>
		</c:forEach>
</tbody>
	</table>
	<jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>
	</c:if>
<c:if test="${empty list}">
<h2>
<font color="red">没有符合条件的!</font>
</h2>
</c:if>
	