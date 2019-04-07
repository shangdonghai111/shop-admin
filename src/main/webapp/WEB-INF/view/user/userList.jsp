<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/2/28
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>用户查询</title>
    <%--fileInput--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/datetimepicker/build/build_standalone.less" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath()%>/fileInput5/css/fileinput.min.css" rel="stylesheet" type="text/css"/>

</head>
<style>
    ul li a{
        color: black;
    }
    .show-grid [class ^="col-"] {
        padding-top: 10px;
        padding-bottom: 10px;
        background-color: #eee;
        border: 1px solid #ddd;
        background-color: rgba(86, 61, 124, .15);
        border: 1px solid rgba(86, 61, 124, .2);
    }

    #wrapper {
        padding-left: 0;
        -webkit-transition: all 0.5s ease;
        -moz-transition: all 0.5s ease;
        -o-transition: all 0.5s ease;
        transition: all 0.5s ease;
    }

    #wrapper.toggled {
        padding-left: 250px;
    }

    #sidebar-wrapper {
        z-index: 1000;
        position: fixed;
        left: 250px;
        width: 0;
        height: 100%;
        margin-left: -250px;
        overflow-y: auto;
        background: #F5F5F5;
        -webkit-transition: all 0.5s ease;
        -moz-transition: all 0.5s ease;
        -o-transition: all 0.5s ease;
        transition: all 0.5s ease;
    }

    #wrapper.toggled #sidebar-wrapper {
        width: 250px;
    }

    #page-content-wrapper {
        width: 100%;
        position: absolute;
        padding: 15px;
    }

    #wrapper.toggled #page-content-wrapper {
        position: absolute;
        margin-right: -250px;
    }

    /* Sidebar Styles */

    .sidebar-nav {
        position: absolute;
        top: 0;
        width: 250px;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .sidebar-nav li {
        text-indent: 20px;
        line-height: 40px;
    }

    .sidebar-nav li a {
        display: block;
        text-decoration: none;
        color: #999999;
    }

    .sidebar-nav li a:hover {
        text-decoration: none;
        color: #fff;
        background: rgba(255,255,255,0.2);
    }

    .sidebar-nav li a:active,
    .sidebar-nav li a:focus {
        text-decoration: none;
    }

    .sidebar-nav > .sidebar-brand {
        height: 65px;
        font-size: 18px;
        line-height: 60px;
    }

    .sidebar-nav > .sidebar-brand a {
        color: #999999;
    }

    .sidebar-nav > .sidebar-brand a:hover {
        color: #fff;
        background: none;
    }

    @media(min-width:768px) {
        #wrapper {
            padding-left: 250px;
        }

        #wrapper.toggled {
            padding-left: 0;
        }

        #sidebar-wrapper {
            width: 250px;
        }

        #wrapper.toggled #sidebar-wrapper {
            width: 0;
        }

        #page-content-wrapper {
            padding: 20px;
            position: relative;
        }

        #wrapper.toggled #page-content-wrapper {
            position: relative;
            margin-right: 0;
        }
    }
</style>
<body>

<div id="navbar" class="collapse navbar-collapse" style="background-color:deeppink;">
    <div style="float: left">
        <ul style="font-size: 30px;" class="nav nav-tabs">
            <li role="presentation"><a  href="#">金科教育</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/brand/toqueryBrandList.jhtml">品牌管理</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/user/toQueryUserList.jhtml">用户管理</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/log/toQueryLogList.jhtml">日志管理</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/product/toProductList.jhtml">商品管理</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/city/toCityList.jhtml">地区管理</a></li>
            <li role="presentation"><a href="<%=request.getContextPath()%>/member/toMemberList.jhtml">会员管理</a></li>
        </ul>
    </div>
    <div style="float: left;color: white">
        尊敬的会员:${sessionScope.user.userName}您好！
        您今天登陆了:${sessionScope.user.count}次了！
        上次登陆时间为: <f:formatDate  value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss" type="date"></f:formatDate>
    </div>
</div>
<%--导航条下面的大div--%>
<div id="wrapper">
    <%--左边的ztree--%>
    <div id="sidebar-wrapper">
        <div class="zTreeDemoBackground left">
            <div class="container-fluid">
                <div class="row">
                    <div class="panel panel-primary">
                        <div id="bumen"  class="panel-heading">部门管理
                            <button class="btn btn-primary" type="button" onclick="toAddDept();">
                                <span class="glyphicon glyphicon-plus" ></span>
                                增加
                            </button>
                            <button class="btn btn-danger" type="button" onclick="deleteDept();">
                                <span class="glyphicon glyphicon-trash"></span>
                                删除
                            </button>
                            <button class="btn btn-warning" type="button" onclick="findOneDept();">
                                <span class="glyphicon glyphicon-pencil"></span>
                                修改
                            </button>
                        </div>
                    </div>
                    <div id="ulTreedemo" class="panel-body">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                </div>
            </div>


        </div>
    </div>
    <%--右边的展示的大div--%>
        <div id="page-content-wrapper ">
            <form id="userForm" class="form-horizontal" role="form">
                <fieldset>
                    <legend style="background-color: #6A6AFF">条件查询</legend>
                   <%-- <div class="form-group">
                        <label class="col-sm-2 control-label">用户名：</label>
                        <div class="col-sm-4">
                            <input class="form-control" id="userName" name="userName" type="text"/>
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户名：</label>
                        <div class="col-sm-3">
                            <input class="form-control" id="userName" name="userName" type="text"/>
                        </div>
                        <label class="col-sm-2 control-label">商品价格</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input type="text" class="input-sm form-control" id="minSalary"/>
                                <span class="input-group-addon">
								<i class="glyphicon glyphicon-yen"></i>
                            </span>
                                <input type="text" class="input-sm form-control" id="maxSalary"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">真实姓名：</label>
                        <div class="col-sm-3">
                            <input class="form-control" id="userRealName" name="userRealName" type="text"/>
                        </div>
                        <label class="col-sm-2 control-label">生日：</label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <input size="16" type="text"  readonly class="input-sm form-control" id="minBirthday">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-calendar"></i>
                    </span>
                                <input size="16" type="text" readonly class="input-sm form-control" id="maxBirthday">
                            </div>
                        </div>
                    </div>
                </fieldset>
                <div id="" class="clearfix form-actions" style="text-align:center">
                    <input id="detpIds"/>
                    <button class="btn btn-primary" type="button" onclick="search();">
                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                        查询
                    </button>
                    <button class="btn btn-primary"  onclick="refersh()">
                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                        重置
                    </button>
                    <button class="btn btn-primary" type="button" onclick="toAddUser();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                        增加
                    </button>
                    <button class="btn btn-primary" type="button" onclick="deleteAllUser();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                        批量删除
                    </button>
                    <button  class="btn btn-primary" type="button" onclick="updateUser();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                        修改用户
                    </button>
                    <button class="btn btn-primary" type="button" onclick="updateAllDept();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                        批量修改部门
                    </button>
                    <button class="btn btn-primary" type="button" onclick=" importExcelByDept();">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                        导出部门excel
                    </button>
                </div>
            </form>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">用户列表</h3>
                </div>
                <div class="panel-body">
                    <table id="a" class="table table-condensed" style="width:100%">
                        <thead>
                        <tr>
                            <th>用户id</th>
                            <th>用户名字</th>
                            <th>用户头像</th>
                            <th>账号状态</th>
                            <th>真实姓名</th>
                            <th>生日</th>
                            <th>性别</th>
                            <th>薪资要求</th>
                            <th>所属部门</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>用户id</th>
                            <th>用户名字</th>
                            <th>用户头像</th>
                            <th>账号状态</th>
                            <th>真实姓名</th>
                            <th>生日</th>
                            <th>性别</th>
                            <th>薪资要求</th>
                            <th>所属部门</th>
                            <th>操作</th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
</div>


<%--增加部门的div--%>
<div id="addDept" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="deptName" class="col-md-2 control-label">部门名</label>
            <input id="parentId"/>
            <div class="col-md-4">
                <input class="form-control" name="deptName" id="deptName" placeholder="部门名...">
            </div>
        </div>
        <div class="form-group">
            <label for="remary" class="col-md-2 control-label">部门描述</label>
            <div class="col-md-4">
               <textarea class="form-control" id="remary" ></textarea>
            </div>
        </div>
    </form>
</div>

<%--修改部门的div--%>
<div id="editDept" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="deptName" class="col-md-2 control-label">部门名</label>
            <input id="edit_id"/>
            <div class="col-md-4">
                <input class="form-control" id="edit_deptName" placeholder="部门名...">
            </div>
        </div>
        <div class="form-group">
            <label for="remary" class="col-md-2 control-label">部门描述</label>
            <div class="col-md-4">
                <textarea class="form-control" id="edit_remary" ></textarea>
            </div>
        </div>
    </form>
</div>

<%--增加用户的div--%>
<div id="addUser" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="userNameIn" class="col-md-2 control-label">用户名</label>
            <div class="col-md-4">
                <input class="form-control" id="userNameIn" placeholder="用户名...">
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-md-2 control-label">密码</label>
            <div class="col-md-4">
                <input class="form-control" id="password" placeholder="密码...">
            </div>
        </div>
        <div class="form-group">
            <label for="entryPassword" class="col-md-2 control-label">确认密码</label>
            <div class="col-md-4">
                <input class="form-control" id="entryPassword" placeholder="确认密码...">
            </div>
        </div>
        <div class="form-group">
            <label for="userRealNameInfo" class="col-md-2 control-label">真实姓名</label>
            <div class="col-md-4">
                <input class="form-control" id="userRealNameInfo" placeholder="真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label for="userBirthday" class="col-md-2 control-label">生日</label>
            <div class="col-md-4">
                <input  class="form-control" id="userBirthday" placeholder="真实姓名...">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-md-2 control-label">图像</label>
            <div class="col-md-8">
            <input type="file" class="form-control" name="headImage" id="headImage" multiple/>
                <input type="text" class="form-control"  id="headPath" multiple/>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-md-2 control-label">性别</label>
            <div class="col-md-4">
                <input type="radio" name="sex" value="1">男
                <input type="radio" name="sex" value="2">女
            </div>
        </div>
        <div class="form-group">
            <label for="xinzi" class="col-md-2 control-label">薪资</label>
            <div class="col-md-4">
                <input class="form-control" id="xinzi" placeholder="薪资...">
            </div>
        </div>
        <div id="bu" class="form-group">
            <label  class="col-md-2 control-label">部门</label>
            <div class="col-md-4">
                <input type="text" id="deptNameInfo" class="form-control" placeholder="部门...">
                <input type="text" id="deptId" class="form-control">
                <span class="input-group-btn">
        <button class="btn btn-primary" type="button" onclick="bumen(v_dialogInfoAddUser,'deptNameInfo','deptId')">选择部门</button>
      </span>
            </div>
        </div>
    </form>
</div>

  <%--  节点名称:<input  name="deptName" id="deptName"><br></br>
    部门描述:<textarea id="remary" cols="50" rows="5"></textarea>--%>
<%--修改用户的div--%>
<div id="editUserDialog" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="userNameIn" class="col-md-2 control-label">用户名</label>
            <div class="col-md-4">
                <input class="form-control" id="edit_userName" placeholder="用户名...">
                <input class="form-control" id="edit_userId">
            </div>
        </div>
        <div class="form-group">
            <label for="userRealNameInfo" class="col-md-2 control-label">真实姓名</label>
            <div class="col-md-4">
                <input class="form-control" id="edit_userRealName" placeholder="">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-md-2 control-label">图像</label>
            <div class="col-md-8">
                <img style="width: 100px;height: 100px" id="img">
                <input type="file" class="form-control" name="headImageInfo" id="headImageInfo" multiple/>
                <input type="text" class="form-control"  id="headPathInfo" multiple/>
            </div>
        </div>
        <div class="form-group">
            <label for="userBirthday" class="col-md-2 control-label">生日</label>
            <div class="col-md-4">
                <input  class="form-control" id="edit_userBirthday" >
            </div>
        </div>
        <div class="form-group">
            <label  class="col-md-2 control-label">性别</label>
            <div class="col-md-4">
                <input type="radio" name="edit_sex" value="1">男
                <input type="radio" name="edit_sex" value="2">女
            </div>
        </div>
        <div class="form-group">
            <label for="xinzi" class="col-md-2 control-label">薪资</label>
            <div class="col-md-4">
                <input class="form-control" id="edit_xinzi" >
            </div>
        </div>
        <div  class="form-group">
            <label  class="col-md-2 control-label">部门</label>
            <div class="col-md-4">
                <input type="text" id="edit_deptNameInfo" class="form-control" placeholder="部门...">
                <input type="text" id="edit_deptId" class="form-control">
                <span class="input-group-btn">
        <button class="btn btn-primary" type="button" onclick="bumen(edit_dialog,'edit_deptNameInfo','edit_deptId')">选择部门</button>
      </span>
            </div>
        </div>
    </form>
</div>
<%--增加用户ztreediv--%>
<div id="deptTreeDiv" class="panel-body" style="display: none">
    <ul id="daptTree2" class="ztree"></ul>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dateFormat.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/contextPath.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/shop.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootbox/bootbox.all.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootbox/bootbox.locales.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/zTree_v3-master/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fileInput5/js/fileinput.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/fileInput5/js/locales/zh.js"></script>
<script>
    $(document).ready(function () {
        initTable();//加载表格
        search();//条件查询
        initDate();//加载时间
        initDeptTree();//加载部门表ztree
        initBind();
        initBirthday();
        initHeadImage();
        updateHeadImage();

    });

    //加载主图片fileInput
 function initHeadImage() {
     var info={
         language : 'zh',
         uploadUrl:"/uploadHeadImage.jhtml",
         showUpload : false, //是否显示上传按钮,跟随文本框的那个
         showRemove : false, //显示移除按钮,跟随文本框的那个
         allowedPreViewTypes:['image'],//预览的类型
         allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
     };
     $("#headImage").fileinput(info).on("fileuploaded",function(event, t, previewId, index){
       var result = t.response;
        if (result.code==200){
            $("#headPath",v_dialogInfoAddUser).val(result.data);
        }

     });

 }
/*    function updateHeaderImage(){
        var s= {
            //初始化上传文件框
            language: "zh",//配置语言
            showUpload: true, //显示整体上传的按钮
            showRemove: true,//显示整体删除的按钮
            uploadAsync: true,//默认异步上传
            uploadLabel: "上传",//设置整体上传按钮的汉字
            removeLabel: "移除",//设置整体删除按钮的汉字
            uploadClass: "btn btn-primary",//设置上传按钮样式
            showCaption: true,//是否显示标题
            dropZoneEnabled: false,//是否显示拖拽区域
            uploadUrl: "/uploadHeadImage.jhtml",//这个是配置上传调取的后台地址，本项目是SSM搭建的
            maxFileSize: 666,//文件大小限制
            maxFileCount: 10,//允许最大上传数，可以多个，
            enctype: 'multipart/form-data',
            allowedFileExtensions: ["jpg", "png", "gif", "docx", "zip", "xlsx", "txt"], /!*上传文件格式限制*!/
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
            showBrowse: true,
            browseOnZoneClick: true,
            initialPreview:'<img id="imgInfo"  class="file-preview-image" style="width:150px">',
            slugCallback: function (filename) {
                return filename.replace('(', '_').replace(']', '_');
            }
        }
        $("#headImageInfo").fileinput(s).on("fileuploaded", function (event, data, previewId, index) {
            //$("#userImagePath").val(data.response.data);

        })
    }*/

    //修改主图片fileInput
   function updateHeadImage() {
        var info={
            language : 'zh',
            uploadUrl:"/uploadHeadImageInfo.jhtml",
            showUpload : false, //是否显示上传按钮,跟随文本框的那个
            showRemove : false, //显示移除按钮,跟随文本框的那个
            allowedPreViewTypes:['image'],//预览的类型
            allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
        };
        $("#headImageInfo").fileinput(info).on("fileuploaded",function(event, t, previewId, index){
            var result = t.response;
            if (result.code==200){
                $("#headPathInfo",edit_dialog).val(result.data);
            }

        });
    }
    //刷新
    function refersh() {
        //清空查询信息
        $("#userName").val("");
        $("#userRealName").val("")
        $("#minSalary").val("");
        $("#maxSalary").val("");
        $("#minBirthday").val("");
        $("#maxBirthday").val("");
        $("#maxBirthday").val("");
        $("#detpIds").val("");
        //清空数组
        v_arr=[];
        //清空选中节点
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        treeObj.cancelSelectedNode();
        //刷新
        search();
    }
    //导出部门excel
   var v_nodeChildrenId=[];
    function importExcelByDept() {
        //获取tree对象
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
//获取选中的节点
        var v_selectedNodes = treeObj.getSelectedNodes();
//获取选中节点的儿子
        var nodes = v_selectedNodes[0].children;
        for (var i=0;i<nodes.length;i++) {
            v_nodeChildrenId.push(nodes[i].id);
        }
        var productFrom = document.getElementById("userForm");
        productFrom.action = "<%=request.getContextPath()%>/user/importExcelByDept.jhtml?childNode="+v_nodeChildrenId;
        productFrom.method = "post"
        productFrom.submit();
        v_nodeChildrenId=[];
    }
   /* var setting;
    var nodes;*/
    //修改用户
    var edit_dialog;
    function updateUser() {
        var v_sources=$("#editUserDialog").html();
        //获取选中行的id
        var v_id="";
        var v_selectRowCount = $("#a tbody tr input[type='checkbox']:checked ").length;
        if (v_selectRowCount==1){
            v_id=$("#a tbody tr input[type='checkbox']:checked ")[0].value;
            //发送ajax请求获取用户信息
            $.ajax({
                type: "POST",
                data: {"id":v_id},
                url: "<%=request.getContextPath()%>/user/findUserById.jhtml",
                success: function(result){
                if (result.code==200){
                    var userData = result.data;
                    $("#edit_userId").val(userData.id);
                    $("#edit_userName").val(userData.userName);
                    $("#edit_userRealName").val(userData.userRealName);
                    $("#edit_userBirthday").val(userData.birthday);
                    $("input[name='edit_sex'][value='"+userData.sex+"']").prop("checked",true);
                    $("#edit_xinzi").val(userData.salary);
                    $("#edit_deptNameInfo").val(userData.deptName);
                    $("#edit_deptId").val(userData.deptId);
                    $("#img").attr("src",userData.headPath);



                    //弹出对话框
                    edit_dialog=bootbox.dialog({
                        message: $("#editUserDialog form"),
                        title: "修改员工 ",
                        buttons:
                            {
                                "success" :
                                    {
                                        "label" : "<i class='icon-ok'></i> 确定",
                                        "className" : "btn-sm btn-success",
                                        "callback": function() {
                                            var v_param={};
                                            var v_userName=$("#edit_userName",edit_dialog).val();
                                            var v_edit_userRealName=$("#edit_userRealName",edit_dialog).val();
                                           // var v_edit_userBirthday=$("#edit_userBirthday",edit_dialog).val();
                                            var v_sex=$("input[name='edit_sex']:checked",edit_dialog).val();
                                           var v_salary= $("#edit_xinzi",edit_dialog).val();
                                           var v_deptId= $("#edit_deptId",edit_dialog).val();
                                           var v_userId= $("#edit_userId",edit_dialog).val();
                                           var v_headPath= $("#headPathInfo",edit_dialog).val();
                                           alert(v_headPath);
                                            v_param.userName=v_userName;
                                            v_param.userRealName=v_edit_userRealName;
                                           // v_param.birthday=v_edit_userBirthday;
                                            v_param.sex=v_sex;
                                            v_param.salary=v_salary;
                                            v_param.deptId=v_deptId;
                                            v_param.id=v_userId;
                                            v_param.headPath=v_headPath;
                                            $.ajax({
                                                type: "POST",
                                                data:v_param,
                                                url: "<%=request.getContextPath()%>/user/updateUser.jhtml",
                                                success: function(result){
                                                    if (result.code==200){
                                                        alert("修改成功");
                                                        search();
                                                    }
                                                    else {
                                                        bootbox.alert({
                                                            message:"<span class='glyphicon glyphicon-exclamation-sign '></span>增加失败",
                                                            size:'small',
                                                            title:"提示信息"
                                                        })
                                                    }
                                                }
                                            });
                                        }
                                    },
                                "cancel": {
                                    "label" : "<i class='icon-info'></i> 取消",
                                    "className" : "btn-sm btn-danger",
                                    callback:function () {

                                    }
                                }
                            }


                    });
                    $("#editUserDialog").html(v_sources);
                    initEditBirthday();
                }
                }
            });


        } else {
            bootbox.alert({
                message:"<span class='glyphicon glyphicon-exclamation-sign '></span>只能选择一个员工",
                size:'small',
                title:"提示信息"
            })
        }
    }
    //创建绑定事件
    //定义空数组
    var v_arr=[];
    function initBind() {
        //通过表格的id 给tbody里面的tr绑定一个点击事件
        $("#a tbody").on("click","tr",function () {
            //并给所有tbody里面的tr颜色
           // $(this).css("background","#ccc");
            //获取复选框
            var v_box=$(this).find("input[type='checkbox']:checkbox")[0];
            //判断复选框的状态
            if(v_box.checked){
                $(this).css("background","");
                v_box.checked=false;
                $(this).attr("flag","");
                deleteIds(v_box.value);
            }else{
                $(this).css("background","#ccc");
                v_box.checked=true;
                $(this).attr("flag","1");
                v_arr.push(v_box.value);
            }

        })
    }
    //定义删除的函数
    function deleteIds(id){
        for (var i = v_arr.length-1; i >=0; i--) {
            if(v_arr[i]==id){
                v_arr.splice(i,1);
                break;
            }
        }
    }
    //判断数组中的值和选中的值做对比
    function isExist(id) {
        for (var i=0;i<v_arr.length;i++){
            if (v_arr[i]==id){
                return true;//跳出本次循环
            }
        }

    }

    //批量删除用户
    function deleteAllUser() {
        if(v_arr.length>0){
            var v_ids=v_arr.join(",");
            /*BootBox*/
            bootbox.confirm({
                message: "你确定要删除吗?",
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-success',
                        return:true,
                    },
                    cancel: {
                        label: '取消',
                        className: 'btn-danger',
                        return:false,
                    }
                },
                callback: function (result) {
                    if (result==true) {
                        $.ajax({
                            url:"<%=request.getContextPath()%>/user/deleteAll.jhtml",
                            type:"post",
                            data:{"ids":v_ids},
                            success:function(res){
                                if(res.code==200){
                                    bootbox.alert("删除成功");

                                    search(1);
                                }

                            }
                        })


                    }
                }
            });
        }
        else{
            alert("请至少选择一条")
        }
    }

    //增加用户
    var v_dialogInfoAddUser="";
    function toAddUser() {
        //获得原始数据
        var v_sources=$("#addUser").html();
        //获取选中的节点集合
        v_dialogInfoAddUser=bootbox.dialog({
            message: $("#addUser form"),
            title: "添加员工 ",
            buttons:
                {
                    "success" :
                        {
                            "label" : "<i class='icon-ok'></i> 确定",
                            "className" : "btn-sm btn-success",
                            "callback": function() {
                                //var v_deptName=$("input[name='deptName']").last().val();
                                //获取弹出框里面的input 文本域中的值  利用上下文
                                var v_userNameIn=$("#userNameIn",v_dialogInfoAddUser).val();
                                var v_password=$("#password",v_dialogInfoAddUser).val();
                                var v_entryPassword=$("#entryPassword",v_dialogInfoAddUser).val();
                                var v_userRealNameInfo=$("#userRealNameInfo",v_dialogInfoAddUser).val();
                                var v_userBirthday=$("#userBirthday",v_dialogInfoAddUser).val();
                                var v_sex=$("input[name='sex']:checked",v_dialogInfoAddUser).val();
                                var v_xinzi=$("#xinzi",v_dialogInfoAddUser).val();
                                var v_deptId=$("#deptId",v_dialogInfoAddUser).val();
                                var v_headPath=$("#headPath",v_dialogInfoAddUser).val();
                                var v_param={};
                                v_param.userName=v_userNameIn;
                                v_param.userPwd=v_entryPassword;
                                v_param.userRealName=v_userRealNameInfo;
                                v_param.birthday=v_userBirthday;
                                v_param.sex=v_sex;
                                v_param.salary=v_xinzi;
                                v_param.deptId=v_deptId;
                                v_param.headPath=v_headPath;
                                $.ajax({
                                    type: "POST",
                                    data:v_param,
                                    url: "<%=request.getContextPath()%>/user/add.jhtml",
                                    dataType:'json',
                                    cache: false,
                                    success: function(result){
                                        if (result.code==200){
                                            alert("增加成功");
                                            search();
                                        }
                                       else {
                                            bootbox.alert({
                                                message:"<span class='glyphicon glyphicon-exclamation-sign '></span>增加失败",
                                                size:'small',
                                                title:"提示信息"
                                            })
                                        }
                                    }
                                });
                            }
                        },
                    "cancel": {
                        "label" : "<i class='icon-info'></i> 取消",
                        "className" : "btn-sm btn-danger",
                        callback:function () {

                        }
                    }
                }


        });
         //回填并再次进行组件的初始化
        $("#addUser").html(v_sources);
        //加载时间
        initBirthday();
    }
    //部门加载
    function bumen(v_dept,deptNameId,deptId){
      /*  $("#deptTreeDiv").html("<ul id='daptTree2' class='ztree'></ul>");
        $.fn.zTree.init($("#daptTree2"),setting,nodes);
        /!*bootbox弹框*!/
       bootbox.dialog({
            title: '请选择部门',
            message: $("#deptTreeDiv ul"),
            // size: 'large',
            buttons: {
                ok: {
                    label: '<span class="glyphicon glyphicon-ok"></span>确定',
                    className: 'btn-success',
                    callback: function () {

                    }
                },
                cancel: {
                    label: '<span class="glyphicon glyphicon-remove"></span>取消',
                    className: 'btn-danger',
                    callback: function () {
                        //Example.show('Custom cancel clicked');
                    }
                }
            },
        });*/

        var v_souces=$("#deptTreeDiv").html();
      //发送ajax请求数据
        $.ajax({
            url:"<%=request.getContextPath()%>/dept/queryDept.jhtml",
            type:"post",
            success:function (result) {
                setting = {
                    callback: {
                        //单击事件
                        onClick : zTreeOnClick
                    },
                    data: {
                        simpleData: {
                            enable: true,
                            pIdKey: "parentId",

                        },
                        key:{
                            name:"deptName"
                        },
                    }
                };
                if (result.code==200){
                    //渲染
                    $.fn.zTree.init($("#daptTree2"), setting, result.data);
                    //弹出对话框
                    bootbox.dialog({
                        message: $("#daptTree2"),
                        title: "选择部门 ",
                        buttons:
                            {
                                "success" :
                                    {
                                        "label" : "<i class='icon-ok'></i> 确定",
                                        "className" : "btn-sm btn-success",
                                        "callback": function() {
                                            //获取树的选中节点
                                            var treeObj = $.fn.zTree.getZTreeObj("daptTree2");
                                            var nodes = treeObj.getSelectedNodes();
                                            if (nodes.length==1){
                                                var v_deptId=nodes[0].id;
                                                var v_deptName=nodes[0].deptName;
                                                //回填到用户对话框中的指定元素中
                                                $("#"+deptNameId,v_dept).val(v_deptName);
                                                $("#"+deptId,v_dept).val(v_deptId);

                                            }
                                            else {
                                                bootbox.alert({
                                                    message:"<span class='glyphicon glyphicon-exclamation-sign '></span>只能选择一个部门",
                                                    size:'small',
                                                    title:"提示信息"
                                                })
                                            }

                                        }
                                    },
                                "cancel": {
                                    "label" : "<i class='icon-info'></i> 取消",
                                    "className" : "btn-sm btn-danger",
                                    callback:function () {

                                    }
                                }
                            }


                    });
                    //回填树
                    $("#deptTreeDiv").html(v_souces);
                }else {
                    bootbox.alert({
                        message:"<span class='glyphicon glyphicon-exclamation-sign '></span>获取部门失败",
                        size:'small',
                        title:"提示信息"
                    })
                }

            }

        })

    }
    //修改ztree
    function findOneDept() {
        //获取当前选中的节点集合
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            var v_node = nodes[0];
            var deptName = nodes[0].deptName;
            var remary = nodes[0].remary;
            var v_id=$("#edit_id").attr("value",v_node.id);
            var v_deptName=$("#edit_deptName").attr("value",deptName);
            var v_remary=$("#edit_remary").html(remary);
            var v_editDialog=bootbox.dialog({
                message: $("#editDept").html(),
                title: "修改部门 ",
                buttons:
                    {
                        "success" :
                            {
                                "label" : "<i class='icon-ok'></i> 确定",
                                "className" : "btn-sm btn-success",
                                "callback": function() {
                                    //获取弹出框里面的input 文本域中的值  利用上下文
                                    var v_deptName=$("#edit_deptName",v_editDialog).val();
                                    var v_remary=$("#edit_remary",v_editDialog).val();
                                    var v_id=$("#edit_id",v_editDialog).val();
                                    var v_param={};
                                    v_param.deptName=v_deptName;
                                    v_param.remary=v_remary;
                                    v_param.id=v_id;
                                    $.ajax({
                                        type: "POST",
                                        data:v_param,
                                        url: "<%=request.getContextPath()%>/dept/updateDept.jhtml",
                                        dataType:'json',
                                        cache: false,
                                        success: function(result){
                                            if (result.code==200){
                                                alert("修改成功");
                                                //initDeptTree();
                                                //成功动态ztree节点
                                               var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                                                v_node.deptName=v_deptName;
                                                v_node.remary=v_remary;
                                                treeObj.updateNode(v_node);

                                            }
                                        }
                                    });
                                }
                            },
                        "cancel": {
                            "label" : "<i class='icon-info'></i> 取消",
                            "className" : "btn-sm btn-danger"
                        }
                    }


            });
        } else {
            alert("确认是否选择或者选择太多")
        }
    }
    //删除ztree
    function deleteDept() {
        //获取当前选中的节点集合
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();


      if (nodes.length>0){
          var array = treeObj.transformToArray(nodes);
          var v_ids=[];
          for (var i=0;i<array.length;i++){
              v_ids.push(array[i].id);
          }
          /*console.log(v_ids);*/
          bootbox.confirm({
              message: "你确定要删除吗?",
              buttons: {
                  confirm: {
                      label: '确定',
                      className: 'btn-success',
                      return:true,
                  },
                  cancel: {
                      label: '取消',
                      className: 'btn-danger',
                      return:false,
                  }
              },
              callback: function (result) {
                  if (result==true) {
                      $.ajax({
                          url:"<%=request.getContextPath()%>/dept/deleteDept.jhtml",
                          type:"post",
                          data:{"ids":v_ids},
                          success:function(res){
                            if (res.code==200){
                                //前台刷新
                                for (var i=0;i<array.length;i++){
                                    treeObj.removeNode(array[i]);
                                }
                                alert("删除成功")
                            }

                          }
                      })
                  }
              }
          });
      }
      else {
          bootbox.alert({
              message:"<span class='glyphicon glyphicon-exclamation-sign '></span>请确认选择",
              size:'small',
              title:"提示信息"
          })
      }

    }
    //批量修改用户部门
    var arr=[];
    function updateAllDept(v_dept,deptNameId,deptId) {
        var v_souces=$("#deptTreeDiv").html();
        if(v_arr.length>0){
             arr = v_arr
            //发送ajax请求数据
            $.ajax({
                url:"<%=request.getContextPath()%>/dept/queryDept.jhtml",
                type:"post",
                success:function (result) {
                    setting = {
                        callback: {
                            //单击事件
                            onClick : zTreeOnClick
                        },
                        data: {
                            simpleData: {
                                enable: true,
                                pIdKey: "parentId",

                            },
                            key:{
                                name:"deptName"
                            },
                        }
                    };

                    if (result.code==200){
                        //渲染
                        $.fn.zTree.init($("#daptTree2"), setting, result.data);
                        //弹出对话框
                        bootbox.dialog({
                            message: $("#daptTree2"),
                            title: "选择部门 ",
                            buttons:
                                {
                                    "success" :
                                        {
                                            "label" : "<i class='icon-ok'></i> 确定",
                                            "className" : "btn-sm btn-success",
                                            "callback": function() {
                                                //获取树的选中节点
                                                var treeObj = $.fn.zTree.getZTreeObj("daptTree2");
                                                var nodes = treeObj.getSelectedNodes();
                                                if (nodes.length==1){
                                                    var v_deptId=nodes[0].id;
                                                  $.ajax({
                                                        url:"<%=request.getContextPath()%>/user/updateAllDeptId.jhtml",
                                                        type:"post",
                                                        data:{
                                                            "deptId":v_deptId,
                                                               "ids":arr
                                                        },
                                                        success:function(res){
                                                         if(res.code==200){
                                                          bootbox.alert("修改成功");
                                                         search(1);
                                                         }

                                                        }
                                                     })

                                                }
                                                else {
                                                    bootbox.alert({
                                                        message:"<span class='glyphicon glyphicon-exclamation-sign '></span>只能选择一个部门",
                                                        size:'small',
                                                        title:"提示信",

                                                    })
                                                    return;

                                                }

                                            }
                                        },
                                    "cancel": {
                                        "label" : "<i class='icon-info'></i> 取消",
                                        "className" : "btn-sm btn-danger",
                                        callback:function () {

                                        }
                                    }
                                }


                        });
                        //回填树
                        $("#deptTreeDiv").html(v_souces);
                    }else {
                        bootbox.alert({
                            message:"<span class='glyphicon glyphicon-exclamation-sign '></span>获取部门失败",
                            size:'small',
                            title:"提示信息"
                        })
                    }

                }

            })
           /* $.ajax({
                url:"/user/updateAllDept.jhtml",
                type:"post",
                data:{"ids":v_ids},
                success:function(res){
                    if(res.code==200){
                        bootbox.alert("修改成功");
                        search(1);
                    }

                }
            })*/










        }
        else{
            alert("请至少选择一条")
        }
    }
    //增加ztree
    var v_dialog;
    function toAddDept() {
        //获取当前选中的节点集合
      var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            var v_node = nodes[0];
            var v_id=v_node.id;
            alert(v_id);
            //$("#addDept",v_dialog).val(v_id);
        /*    $("#deptInfo").attr("value",v_id);*/
           $("#parentId").attr("value",v_id);
             v_dialog=bootbox.dialog({
                message: $("#addDept").html(),
                title: "添加部门 ",
                buttons:
                    {
                        "success" :
                            {
                                "label" : "<i class='icon-ok'></i> 确定",
                                "className" : "btn-sm btn-success",
                                "callback": function() {
                                    //var v_deptName=$("input[name='deptName']").last().val();
                                    //获取弹出框里面的input 文本域中的值  利用上下文
                                    var v_deptName=$("#deptName",v_dialog).val();
                                    var v_remary=$("#remary",v_dialog).val();
                                    var v_parentId=$("#parentId",v_dialog).val();
                                    var v_param={};
                                    v_param.deptName=v_deptName;
                                    v_param.remary=v_remary;
                                    v_param.parentId=v_parentId;
                                    $.ajax({
                                        type: "POST",
                                        data:v_param,
                                        /*{
                                            "parentId":v_id,
                                            "deptName":v_deptName,
                                            "remary":v_remary
                                        },*/
                                        url: "<%=request.getContextPath()%>/dept/addDept.jhtml",
                                        dataType:'json',
                                        cache: false,
                                        success: function(result){
                                            if (result.code==200){
                                                alert("增加成功");
                                                //成功动态ztree节点
                                                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                                                var node={};
                                                node.deptName=v_deptName;
                                                node.remary=v_remary;
                                                node.id=result.data.id;
                                                treeObj.addNodes(v_node, node);

                                            }
                                        }
                                    });
                                }
                            },
                        "cancel": {
                            "label" : "<i class='icon-info'></i> 取消",
                            "className" : "btn-sm btn-danger"
                        }
                    }


            });
        }
       else {
            bootbox.alert({
                message:"<span class='glyphicon glyphicon-exclamation-sign '></span>请选择一条",
                size:'small',
                title:"提示信息"
            })
        }

    }
    //定义单击事件
    var v_arr=[];
    function zTreeOnClick(event, treeId, treeNode) {
        //alert(treeNode.id + ", " + treeNode.deptName);
        //获取当前选中的节点集合
        $("#detpIds").val();
        v_arr=[];
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        var nodeArr = treeObj.transformToArray(nodes);
       for (var i=0;i<nodeArr.length;i++){
          // $("#detpIds").val( $("#detpIds").val()+","+nodeArr[i].id);
           if (!isExist(nodeArr[i].id)) {
               v_arr.push(nodeArr[i].id);
           }

       } $("#detpIds").val(v_arr.join(","));
       search();

    }
function isExist(id) {
    for (var i=0;i<v_arr.length;i++){
        if (v_arr[i]==id){
            return true;
        }
    }
}
    //部门表ztree

    function initDeptTree() {

        setting = {
            callback: {
                //单击事件
                onClick : zTreeOnClick
            },
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "parentId",
                },
                key:{
                    name:"deptName"
                },
            }
        };
        //ztree数据的展示
        $.ajax({
            url:"<%=request.getContextPath()%>/dept/queryDept.jhtml",
            type:"post",
            success:function (result) {
                if (result.code==200){
                    //渲染
                    $.fn.zTree.init($("#treeDemo"), setting, result.data);
                    //获取当前选中的节点集合
                    var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                     //nodes = treeObj.getNodes();
                     nodes = result.data;
                    treeObj.expandAll(true);//默认展开所有节点
                }else {
                    bootbox.alert({
                        message:"<span class='glyphicon glyphicon-exclamation-sign '></span>获取部门失败",
                        size:'small',
                        title:"提示信息"
                    })
                }

            }

        })


    }
    function initEditBirthday() {
        $("#edit_userBirthday").datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh-CN',
            clearBtn:true,//清除按钮

        })
    }
    function initDate() {
        $("#minBirthday").datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh-CN',
            clearBtn:true,//清除按钮

        })
        $("#maxBirthday").datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })
    }
    function initBirthday() {
        $("#userBirthday").datetimepicker({format: 'yyyy-mm-dd'})
    }
    /* 条件查询 */
    function search(){
        var param={};//动态传参
        param.userName=$("#userName").val();
         param.userRealName=$("#userRealName").val();
        param.minSalary=$("#minSalary").val();
        param.maxSalary=$("#maxSalary").val();
        param.minBirthday=$("#minBirthday").val();
         param.maxBirthday=$("#maxBirthday").val();
         param.maxBirthday=$("#maxBirthday").val();
         param.deptIds=$("#detpIds").val();
        userTable.settings()[0].ajax.data=param;
        userTable.ajax.reload();

    }

    //更改状态
    function findStatus(id) {
        location.href="<%=request.getContextPath()%>/user/updateStatus.jhtml?id="+id;
    }
    var userTable;
    function initTable() {
        userTable=$('#a').DataTable({
            "aoColumnDefs": [
                {
                    "bSortable": false, "aTargets": [0,1,2,3,4,5,6,7,8]       //设置排序
                }
            ],
            "autoWidth": true,//设置自适应宽度
            "info": true,//展示左下角信息
            "lengthChange": true,//是否允许改变每页条数
            "lengthMenu": [ 5, 10, 15, 30, 45],//设置每页条数
            "paging": true,//是否开启分页
            "processing": true,//页面加载慢的时候展示处理状态
            "serverSide": true,//时候开服务器模式
            "bFilter": false,
            "destroy": true,
            "retrieve":true,
            "ajax": {
                "url": "<%=request.getContextPath()%>/user/queryUserList.jhtml",
                "type": "POST",
            },
            //重绘表单
            "drawCallback":function (x) {
                //获取当前页面所有复选框的值
                $("#productTable tbody tr input[type='checkbox']").each(function () {
                    var v_id=$(this).val();
                    if (isExist(v_id)){
                        $(this).closest("tr").css("background","#ccc");
                        this.checked=true;
                    }
                })
            },
            "columns": [
                {
                    "data": "id",
                    render: function (data, type, row, meta) {
                        return "<input type='checkbox' value='" + data + "' name='checkName' id='productTable'>";
                    }
                },
                {"data": "userName"},
                {
                    "data": "headPath",
                    render: function (data, type, row, meta) {
                        return "<img src='"+data+"' width='100px' height='100px'>";
                    }
                },
                {'data': 'userStatus',
                    render:function(data, type, row, meta){
                        if(data==1){
                            return "锁定";
                        }else{
                            return "正常";
                        }}
                },
                {"data": "userRealName"},
                {"data": "birthday",
                    render: function (data, type, row, meta) {
                        if (data != null) {
                            return (new Date(data)).Format("yyyy-MM-dd");
                        }
                        return data;
                    }},
                {"data": "sex",
                    render:function(data, type, row, meta){
                        if(data==1){
                            return "男";
                        }else{
                            return "女";
                        }}},
                {"data": "salary"},
                {"data": "dept.deptName"},
                {
                    "data": "id",sortable : false,
                    render: function (data, type, row, meta) {
                        var buttons = '';
                        buttons += '<button type="button" id="update" onclick="findStatus('+data+')" class="btn btn-xs btn-info">' +
                            '<span class="glyphicon glyphicon-pencil"></span>修改状态</button>';
                        return buttons;
                    }
                },

            ],
            "language": {
                "url": "<%=request.getContextPath()%>/DataTables-1.10.15/media/js/Chinese.json"
            },

        });
    }


</script>

</body>
</html>
