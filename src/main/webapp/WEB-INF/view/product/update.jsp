<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
	<link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/contextPath.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/shop.js"></script>

<title>Insert title here</title>

</head>
<body>
<br>
<form action="<%=request.getContextPath()%>/product/update.jhtml" enctype="multipart/form-data" method="post" class="form-horizontal">
	<div class="form-group">
		<label class="col-sm-2 control-label">名称:</label>
		<div class="col-sm-2">
			<input type="hidden" class="form-control" name="id" value="${product.id}" readonly="readonly"/>
			<input type="hidden" name="productImage" value="${product.productImage}" readonly="readonly"/>
			<input type="text" class="form-control" name="productName" value="${product.productName}"/>
		</div>
	</div>
	<div class="form-group">
		<label  class="col-sm-2 control-label">价格:</label>
		<div class="col-sm-2">
			<input type="text" class="form-control" name="productPrice" value="${product.productPrice}"/>
		</div>
	</div>
	<div class="form-group">
		<label  class="col-sm-2 control-label">图片:</label>
		<div class="col-sm-2">
			<img width="100px" height="100px" src="<%=request.getContextPath()%>${product.productImage}">
			<input type="file" name="productImagePath" value="${product.productImage}"/>

		</div>
	</div>
	<div class="form-group">
		<label  class="col-sm-2 control-label">品牌名字：</label>
		<div class="col-sm-2">
			<select id="blandId" name="brand.id">
				<option value="-1">---请选择---</option>
			</select>
		</div>
	</div>
	<div class="form-group">
		<label  class="col-sm-2 control-label">子图片:
			<input type="hidden" id="son" name="pathUrl"/>
		</label>
		<div class="col-sm-2">
			<c:forEach items="${imagesList}" var="image">
						<span>
							<img width="100px" src="<%=request.getContextPath()%>${image.imagePath}">
							<input  type="button" value="删除" onclick="deleteImage(this,'${image.imagePath}')"/>
						</span>
			</c:forEach>
		</div>
	</div>
	<div data_Image="image" class="form-group">
		<label  class="col-sm-2 control-label">子图片增加:</label>
		<div class="col-sm-2">
			<input type="file" name="productImageUrl"/>
			<input type="button" value="＋" onclick="addImage()"/>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<div class="checkbox">
				<label>
					<input type="checkbox"> Remember me
				</label>
			</div>
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button type="submit" class="btn btn-primary">Submit</button>
			<button type="reset" class="btn btn-default">Reset</button>
		</div>
	</div>
</form>


	<%--<form action="<%=request.getContextPath()%>/product/update.jhtml" enctype="multipart/form-data" method="post">
		<table border="1" cellpadding="0" cellspacing="0" width="60%">
			<tr>
				<td>名称:</td>
				<td><input type="hidden" name="id" value="${product.id}" readonly="readonly"/>
					<input type="hidden" name="productImage" value="${product.productImage}" readonly="readonly"/>
					<input type="text" name="productName" value="${product.productName}"/>
				</td>
			</tr>
			<tr>
				<td>价格:</td>
				<td><input type="text" name="productPrice" value="${product.productPrice}"/></td>
			</tr>
			<tr>
				<td>图片:</td>
				<td>
					<img width="100px" height="100px" src="<%=request.getContextPath()%>${product.productImage}">
					<input type="file" name="productImagePath" value="${product.productImage}"/>
				</td>
			</tr>
			<tr>
				<td>品牌名字：</td>
				<td>
					<select id="blandId" name="brand.id">
						<option value="-1">---请选择---</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>子图片
					<input type="hidden" id="son" name="pathUrl"/>
				</td>
				<td>
					<div style="width: 700px">
						<c:forEach items="${imagesList}" var="image">
						<span>
							<img width="100px" src="<%=request.getContextPath()%>${image.imagePath}">
							<input  type="button" value="删除" onclick="deleteImage(this,'${image.imagePath}')"/>
						</span>
						</c:forEach>

					</div>
				</td>
			</tr>
			<tr data_Image="image">
				<td>子图片增加</td>
				<td>
					<input type="file" name="productImageUrl"/>
					<input type="button" value="＋" onclick="addImage()"/>
				</td>
			</tr>
			<tr>
				<td><input type="submit"></td>
				<td><input type="reset"/></td>
			</tr>
		</table>
	</form>--%>

	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dateFormat.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript">
		//加载函数
		$(function(){
			initSelect("blandId","${product.brand.id}");
		});
		//删除图片
		var v_imgurl="";
		function deleteImage(obj,imgurl) {
			$(obj).parent().remove();
			v_imgurl+=","+imgurl;
			//alert(v_imgurl);
			var s = v_imgurl.substring(1);
			$("#son").val(s);


		};
		//增加行内块
		function addImage() {
			$("div[data_Image=\"image\"]").last().after("<div data_Image=\"image\" class=\"form-group\">\n" +
					"\t\t<label  class=\"col-sm-2 control-label\">子图片增加:</label>\n" +
					"\t\t<div class=\"col-sm-2\">\n" +
					"\t\t\t<input type=\"file\" name=\"productImageUrl\"/>\n" +
					"\t\t\t<input type=\"button\" value=\"＋\" onclick=\"addImage()\"/>\n" +
					"\t\t</div>\n" +
					"\t</div>");
		};
		//删除行
		function removeImage(obj) {
			$(obj).parent().remove();
		}
	</script>
</body>
</html>