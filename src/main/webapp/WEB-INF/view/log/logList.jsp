<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/3/2
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<html>
<head>
    <title>日志展示页面</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/datetimepicker/build/build_standalone.less" rel="stylesheet" type="text/css">

</head>
<style>
    ul li a{
        color: black;
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
<form class="form-horizontal" role="form">
    <fieldset>
        <legend style="background-color: #6A6AFF">条件查询</legend>
        <div class="form-group">
            <label class="col-sm-2 control-label">操作人</label>
            <div class="col-sm-4">
                <input class="form-control" id="userName" name="userName" type="text"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">操作时间</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" id="minOperateTime"  name="minOperateTime"/>
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-forward"></i>
                            </span>
                    <input type="text" class="input-sm form-control" id="maxOperateTime"  name="maxOperateTime"/>
                </div>
            </div>
            <label class="col-sm-2 control-label">花了多少毫秒</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" id="minexecuteTime"   name="minexecuteTime"/>
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-forward"></i>
                            </span>
                    <input type="text" class="input-sm form-control" id="maxexecuteTime"  name="maxexecuteTime"/>
                </div>
            </div>
        </div>
    </fieldset>
    <div class="clearfix form-actions" style="text-align:center">
        <button class="btn btn-primary" type="button" onclick="search();">
            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
            查询
        </button>
        <button class="btn btn-default" type="reset">
            <i class="glyphicon glyphicon-refresh"></i>
            重置
        </button>
        <button class="btn btn-danger" type="button" onclick="deleteAllLog();">
            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
            批量删除
        </button>
    </div>
</form>


<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">日志列表</h3>

    </div>
    <div class="panel-body">
        <table id="logTable" class="table table-condensed" style="width:100%">
            <thead>
            <tr>
                <th>日志id</th>
                <th>操作人</th>
                <th>操作时间</th>
                <th>ip地址</th>
                <th>花了多少毫秒</th>
                <th>做了什么</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>日志id</th>
                <th>操作人</th>
                <th>操作时间</th>
                <th>ip地址</th>
                <th>花了多少毫秒</th>
                <th>做了什么</th>
            </tr>
            </tfoot>
        </table>
    </div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dateFormat.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootbox/bootbox.all.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootbox/bootbox.locales.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

<script>
    $(document).ready(function () {
        initTable();//加载表格
        search();//条件查询
        initBind();//加载所有绑定事件
        initDate();//加载时间

    });
    function initDate() {
        $("#minOperateTime").datetimepicker({
            format: 'yyyy-mm-dd hh:mm',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })
        $("#maxOperateTime").datetimepicker({
            format: 'yyyy-mm-dd hh:mm',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })

    }

    //创建绑定事件
    //定义空数组
    var v_arr=[];
    function initBind() {
        //通过表格的id 给tbody里面的tr绑定一个点击事件
        $("#logTable tbody").on("click","tr",function () {
            //并给所有tbody里面的tr颜色
            //$(this).css("background","#ccc");
            //获取复选框
            var v_box=$(this).find("input[name='checkName']:checkbox")[0];
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


    /* 条件查询 */
    function search(){
        var param={};//动态传参
        param.userName=$("#userName").val();
        logTable.settings()[0].ajax.data=param;
        logTable.ajax.reload();

    }

    //加载表格
        var logTable;
    function initTable() {
        logTable = $('#logTable').DataTable({
            "autoWidth": true,//设置自适应宽度
            "info": true,//展示左下角信息
            "lengthChange": true,//是否允许改变每页条数
            "lengthMenu": [ 30, 60, 90, 120],//设置每页条数
            "paging": true,//是否开启分页
            "processing": true,//页面加载慢的时候展示处理状态
            "serverSide": true,//时候开服务器模式
            "bFilter": false,
            "ajax": {
                "url": "queryLogList.jhtml",
                "type": "POST",
            },
            //重绘表单
            "drawCallback":function (x) {
                //获取当前页面所有复选框的值
                $("#logTable tbody tr input[type='checkbox']").each(function () {
                    var v_id=$(this).val();
                    if (isExist(v_id)){
                        $(this).closest("tr").css("background","#ccc");
                        this.checked=true;
                    }
                })
            },
            "columns": [
                {
                    "data": "id",sortable : false,
                    render: function (data, type, row, meta) {
                        return "<input type='checkbox' value='" + data + "' name='checkName' id='productTable'>";
                    }
                },
                {"data": "userName",sortable : false},
                {
                    "data": "operateTime",sortable : false,
                    render: function (data, type, row, meta) {
                        if (data != null) {
                            return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
                        }
                        return data;
                    }
                },
                {"data": "ipAdress",sortable : false,},
                {"data": "executeTime",sortable : false,},
                {"data": "content",sortable : false,},

            ],
            "language": {
                "url": "<%=request.getContextPath()%>/DataTables-1.10.15/media/js/Chinese.json"
            },

        });
    }
    //批量删除
    function deleteAllLog() {
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
                            url:"<%=request.getContextPath()%>/log/deleteAllLog.jhtml",
                            type:"post",
                            data:{"ids":v_ids},
                            success:function(result){
                                if(result){
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
</script>

</body>
</html>
