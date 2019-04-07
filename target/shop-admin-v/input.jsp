<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/3/19
  Time: 0:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
    <link rel="stylesheet" href="/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" src="/js/jquery-1.7.2.js"></script>

    <%--fileInput--%>
    <link href="/commons/fileinput/css/fileinput.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/commons/fileinput/js/fileinput.min.js"></script>
    <script type="text/javascript" src="/commons/fileinput/js/locales/zh.js"></script>

    <script type="text/javascript" src="/dateFormat.js"></script>
    <script type="text/javascript" src="/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
</head>
<body>

<div class="container">

    <form   class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">员工图像</label>
            <div class="col-sm-6">
                <input id ="empImg" name ="empImg" type ="file"  multiple>
            </div>
        </div>
    </form>

</div>

<script>
    $("#empImg").fileinput({
        uploadUrl:"/upload/uploadImg.jhtml",
        uploadAsync : true, //默认异步上传
        showUpload : true, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption : false,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
        dropZoneEnabled : false,
        maxFileCount : 3,
        enctype : 'multipart/form-data',
        msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        language : 'zh',
        layoutTemplates: {
            actionUpload: '',   //取消上传按钮
            actionZoom: ''      //取消放大镜按钮
        }

    }).on("fileuploaded",function(event, data, previewId, index){
        if(data != null){
            alert(data.response.url);
        }
    });

</script>

</body>
</html>


































