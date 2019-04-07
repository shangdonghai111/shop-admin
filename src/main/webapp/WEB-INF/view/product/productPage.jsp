<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<!--引入css-->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
<!--引入JavaScript-->
<script type="text/javascript" language="javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>

<script>
/* 点击表格的行 给checkbox一个选中状态 */
 /* $(function(){
    $("#a tr").click(function(){
        var input = $(this).find("input[type=checkbox]");//获取checkbox   
        if(this.getAttribute("flag")=="1"){
			this.style.background="";
			this.removeAttribute("flag");
		}else{
			this.style.background="#abcdef";
			this.setAttribute("flag","1");
		}
        //判断当前checkbox是否为选中状态
        if(input.is(":checked")){          
            input.attr("checked",false);
        }else{
            var a=input.attr("checked",true);
           //alert(a.val());
            $("#ids").val(a.val());
        }
    }) 
}) 
 */
</script>
<c:if test="${!empty productList}">
<center>

<table id="a" border="1" cellspacing="0">
<thead>
	<tr>
		<th>序号</th>
		<th>商品名字</th>
		<th>商品图片</th>
		<th>
		<input type="button" data-sort-field="price" data-sort="asc" />
		价格
		<input type="button"  data-sort-field="price" data-sort="desc"/>
		</th>
		<th>
		<input type="button"  data-sort-field="entrtyDate" data-sort="asc"/>
		录入时间
		<input type="button"  data-sort-field="entrtyDate" data-sort="desc"/>
		</th>
		<th>
		<input type="button"  data-sort-field="updateDate" data-sort="asc"/>
		修改时间
		<input type="button"  data-sort-field="updateDate" data-sort="desc"/>
		</th>
		<th>品牌名称</th>
		<th>操作</th>
	</tr> 
</thead>
<tbody>
	<c:forEach items="${productList}" var="aa">
		<tr>
		<th>
		<input type="checkbox" onclick="checkOne(this)" name="checkName" value="${aa.id}"/>
		${aa.id}</th>
		<th>${aa.productName}</th>
			<th>
               <img width="100px" height="100px" src="<%=request.getContextPath()%>${aa.productImage}">
				<input type="button" value="查看更多图片" onclick="queryImages('${aa.id}')">
			</th>
		<th>${aa.productPrice}</th>
		<th><fmt:formatDate value='${aa.entrtyTime}' pattern='yyyy-MM-dd HH:mm:ss' type='date'/></th>
		<th><fmt:formatDate value='${aa.updateTime}' pattern='yyyy-MM-dd HH:mm:ss' type='date'/></th>
		<th>${aa.brand.brandName}</th>
		<th>
		<input type="button" value="删除" onclick="deleteProduct('${aa.id}')">
		<input type="button" value="修改" onclick="findProduct('${aa.id}')">
		</th>
	</tr>
	</c:forEach>
</tbody>
</table>
</center>

<%--<jsp:include page="/WEB-INF/common/ajaxpage.jsp"></jsp:include>--%>
<center>
<!-- 增加jsp -->
<div>
<input type="button" value="增加" onclick="toAdd()"/>
</div>
<div id="addJsp" style="display: none">
商品名称：<input id="productame"/></br>
商品价格：<input id="productprice"/></br>
品牌名字：
		<select name="brand.id" id="brandid">
			<option value="-1">---请选择---</option>
			<c:forEach items="${list}" var="aa">
				<option value="${aa.id}">---${aa.brandName}---</option>
			</c:forEach> 
		</select>
	<input type="button" value="保存" onclick="addProduct()"/>
</div>
</center>
</c:if>
<c:if test="${empty productList}">
<center>
<img  src="<%=request.getContextPath()%>/img/da.jpg">
</center>
</c:if>