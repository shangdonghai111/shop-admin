<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/2/18
  Time: 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>增加商品</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/contextPath.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/shop.js"></script>
    <%--fileInput--%>
    <link href="/commons/fileinput/css/fileinput.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/commons/fileinput/js/fileinput.min.js"></script>
    <script type="text/javascript" src="/commons/fileinput/js/locales/zh.js"></script>
</head>
<script>
    $(function(){
        initSelect("option");
        //加载函数里面传给公共的js中的id值 是个字符串  相当于selest的id的值 传给公共的js中
    });
    //增加行
    function  addImage() {
        $("div[data_Image='image']").last().after("<div  data_Image=\"image\">\n" +
            "        <td>子图片增加</td>\n" +
            "        <td>\n" +
            "            <input type=\"file\" name=\"productImagePath\"/>\n" +
            "            <input type=\"button\" value=\"－\" onclick=\"removeImagePathImage(this)\"/>\n" +
            "        </td>\n" +
            "    </div >");
    };
    //删除行
    function removeImagePathImage(obj) {
    $(obj).parent().remove();
    }
    //添加商品主图
    $("#exampleInputFile").fileinput({//初始化uploadfile控件
        uploadUrl:"<%=request.getContextPath()%>/product/add.jhtml",
        uploadAsync : false, //默认异步上传
        showUpload : false, //是否显示上传按钮,跟随文本框的那个
        showRemove : true, //是否显示删除按钮
        showCaption : false,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        maxFileCount : 3, //表示允许同时上传的最大文件个数
        enctype : 'multipart/form-data',
        msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        language : 'zh',

    }).on("fileuploaded",function(event, data, previewId, index){
        if(data != null){
            alert(data.response.url);
        }
    });

</script>
<body>
</br>
<center>
<form action="<%=request.getContextPath()%>/product/add.jhtml" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="exampleInputEmail1">商品名称：</label>
         <input type="text" name="productName" style="width: 200px" class="form-control" id="exampleInputEmail1" placeholder="name">
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">商品价格：</label>
        <input  style="width: 200px" class="form-control" name="productPrice" id="exampleInputPassword1" placeholder="price">
    </div>
    <div class="form-group">
        <label for="exampleInputFile">商品图片</label>
       <input type="file" name="filePath" id="exampleInputFile"  multiple="multiple" />
    </div>

    <div class="form-group">
        <label for="exampleInputPassword1">品牌名字：</label>
        <select id="option" name="brand.id">
            <option value="-1">---请选择---</option>
        </select>
    </div>
    <div data_Image="image" class="form-group">
        <label for="zitupian">子图片</label>
        <input type="file" name="productImagePath" id="zitupian"/>
        <input type="button" value="＋" onclick="addImage()"/>
    </div>
    <div class="checkbox">
        <label>
            <input type="checkbox"> Check me out
        </label>
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
    <button type="reset" class="btn btn-default">Reset</button>
</form>
</center>
<%--<form action="<%=request.getContextPath()%>/product/add.jhtml" method="post" enctype="multipart/form-data">
<table border="1" cellspacing="0" cellpadding="0" width="60%">
    <tr>
        <td>商品名称：</td>
        <td><input name="productName"/></td>
    </tr>
    <tr>
        <td> 商品价格：</td>
        <td><input name="productPrice"/></td>
    </tr>
    <tr>
        <td>商品图片：</td>
        <td><input id="inputs" type="file" name="filePath"/></td>
    </tr>
    <tr>
        <td> 品牌名字：</td>
        <td><select id="option" name="brand.id">
            <option value="-1">---请选择---</option>
            &lt;%&ndash; <c:forEach items="${queryList}" var="aa">
                <option value="${aa.id}">---${aa.brandName}---</option>
            </c:forEach> &ndash;%&gt;
        </select></td>
    </tr>
    <tr data_Image="image">
        <td>子图片增加</td>
        <td>
            <input type="file" name="productImagePath"/>
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
</body>
</html>
