<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/3/12
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>地区展示</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/datetimepicker/build/build_standalone.less" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
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
                        <div id="bumen"  class="panel-heading">地区管理
                            <button class="btn btn-primary" type="button" onclick="toAddCity();">
                                <span class="glyphicon glyphicon-plus" ></span>
                                增加
                            </button>
                            <button class="btn btn-danger" type="button" onclick="deleteCity();">
                                <span class="glyphicon glyphicon-trash"></span>
                                删除
                            </button>
                            <button class="btn btn-warning" type="button" onclick="findOneCity();">
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

    </div>

</div>
<%--增加部门的div--%>
<div id="addDept" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="deptName" class="col-md-2 control-label">地区名</label>
            <input id="parentId"/>
            <div class="col-md-4">
                <input class="form-control" name="deptName" id="deptName" placeholder="地区名...">
            </div>
        </div>

    </form>
</div>
<%--修改城市的div--%>
<div id="editDept" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label for="deptName" class="col-md-2 control-label">地区名</label>
            <input id="edit_id"/>
            <div class="col-md-4">
                <input class="form-control" id="edit_deptName" placeholder="地区名...">
            </div>
        </div>
    </form>
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

<script>
    $(document).ready(function () {
        initCityTree();//加载地区表ztree
    });
    //修改ztree
    var v_editDialog;
    function findOneCity() {
        //获取当前选中的节点集合
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            var v_node = nodes[0];
            var deptName = nodes[0].cityName;
            var v_id=$("#edit_id").attr("value",v_node.id);
            var v_deptName=$("#edit_deptName").attr("value",deptName);
             v_editDialog=bootbox.dialog({
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
                                    var v_id=$("#edit_id",v_editDialog).val();
                                    var v_param={};
                                    v_param.cityName=v_deptName;
                                    v_param.id=v_id;
                                    $.ajax({
                                        type: "POST",
                                        data:v_param,
                                        url: "<%=request.getContextPath()%>/city/updateCity.jhtml",
                                        dataType:'json',
                                        cache: false,
                                        success: function(result){
                                            if (result.code==200){
                                                alert("修改成功");
                                                //initDeptTree();
                                                //成功动态ztree节点
                                                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                                                v_node.cityName=v_deptName;
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
    function deleteCity() {
        //获取当前选中的节点集合
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();


        if (nodes.length>0){
            var array = treeObj.transformToArray(nodes);
            var v_ids=[];
            for (var i=0;i<array.length;i++){
                v_ids.push(array[i].id);
            }
            console.log(v_ids);
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
                            url:"<%=request.getContextPath()%>/city/deleteCity.jhtml",
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
    var v_dialog;
    function toAddCity() {
        //获取当前选中的节点集合
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            var v_node = nodes[0];
            var v_id=v_node.id;
            //alert(v_id);
            $("#parentId").attr("value",v_id);
            v_dialog=bootbox.dialog({
                message: $("#addDept").html(),
                title: "添加地区 ",
                buttons:
                    {
                        "success" :
                            {
                                "label" : "<i class='icon-ok'></i> 确定",
                                "className" : "btn-sm btn-success",
                                "callback": function() {
                                    var v_deptName=$("#deptName",v_dialog).val();
                                    var v_parentId=$("#parentId",v_dialog).val();
                                    var v_param={};
                                    v_param.cityName=v_deptName;
                                    v_param.fatherId=v_parentId;
                                    $.ajax({
                                        type: "POST",
                                        url: "<%=request.getContextPath()%>/city/addCity.jhtml",
                                        data:v_param,
                                        dataType:'json',
                                        cache: false,
                                        success: function(result){
                                            if (result.code==200){
                                                alert("增加成功");
                                                //成功动态ztree节点
                                                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                                                var node={};
                                                node.cityName=v_deptName;
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
    function zTreeOnClick() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length==1){
            var v_id = nodes[0].id;
            $("#parentId").attr("value",v_id);
    //alert(v_id)
        }else {
            bootbox.alert({
                message:"<span class='glyphicon glyphicon-exclamation-sign '></span>请选择一条",
                size:'small',
                title:"提示信息"
            })
        }




    }
    //地区ztree
    function initCityTree() {

        setting = {
            callback: {
                //单击事件
                onClick : zTreeOnClick
            },
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "fatherId",

                },
                key:{
                    name:"cityName"
                },
            }
        };
        //ztree数据的展示
        $.ajax({
            url:"<%=request.getContextPath()%>/city/queryCityList.jhtml",
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
                        message:"<span class='glyphicon glyphicon-exclamation-sign '></span>获取地区失败",
                        size:'small',
                        title:"提示信息"
                    })
                }

            }

        })


    }
</script>
</body>
</html>
