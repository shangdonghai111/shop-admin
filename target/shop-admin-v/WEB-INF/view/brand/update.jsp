<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
</head>
<body>
<form action="<%=request.getContextPath()%>/brand/update.jhtml" method="post" class="form-horizontal">
	<fieldset style="text-align: center">
		<legend style="font-size: 30px;color: deeppink">修改品牌</legend>

		<div  class="form-group">
			<div class="col-sm-3"></div>
			<label for="brandName" class="col-sm-2 control-label">产品名字：</label>
			<div class="col-sm-2">
				<input type="hidden" name="id" readonly="readonly" value="${brand.id}"></br>
				<input type="text" class="form-control" id="brandName" value="${brand.brandName}" name="brandName" >
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-5">
				<div class="col-sm-4"></div>
				<button type="submit"  class="btn btn-default">提交</button>
				<button type="reset" class="btn btn-default">重置</button>

			</div>
		</div>
	</fieldset>
</form>
	<%--<form action="<%=request.getContextPath()%>/brand/update.jhtml" method="post">
	id:<input name="id" readonly="readonly" value="${brand.id}"></br>
	品牌名字:<input name="brandName" value="${brand.brandName}"></br>
	<input type="submit"><input type="reset">
	</form>--%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
</body>
</html>