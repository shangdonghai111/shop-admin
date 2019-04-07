<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/2/28
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<html>
<head>
    <title>品牌展示</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
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
            <label class="col-sm-2 control-label">品牌名称</label>
            <div class="col-sm-4">
                <input class="form-control" id="brandName" name="brandName" type="text"/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">创建时间</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" id="minEntrtyTime" onclick="WdatePicker({skin:'whyGreen'})" name="minCreateTime"/>
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-forward"></i>
                            </span>
                    <input type="text" class="input-sm form-control" id="maxEntrtyTime" onclick="WdatePicker({skin:'whyGreen'})" name="maxCreateTime"/>
                </div>
            </div>
            <label class="col-sm-2 control-label">修改时间</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" id="minUpdateTime"  onclick="WdatePicker({skin:'whyGreen'})" name="minUpdateTime"/>
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-forward"></i>
                            </span>
                    <input type="text" class="input-sm form-control" id="maxUpdateTime" onclick="WdatePicker({skin:'whyGreen'})" name="maxUpdateTime"/>
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
        <button class="btn btn-primary" type="button" onclick="toAdd();">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            增加
        </button>
    </div>
</form>

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">品牌列表</h3>
            </div>
            <div class="panel-body">
                <table id="brandTable" class="table table-condensed" style="width:100%">
                    <thead>
                    <tr>
                        <th>品牌id</th>
                        <th>品牌名字</th>
                        <th>录入时间</th>
                        <th>修改时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>品牌id</th>
                        <th>品牌名字</th>
                        <th>录入时间</th>
                        <th>修改时间</th>
                        <th>操作</th>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>


<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dateFormat.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
        <script>
            $(document).ready(function () {
                initTable();//加载表格
                search();//条件查询
                initBind();//加载所有绑定事件

            });
            //增加
            function toAdd() {
                location.href="<%=request.getContextPath()%>/brand/toAdd.jhtml";
            }
            //创建绑定事件
            //定义空数组
            var v_arr=[];
            function initBind() {

                //通过表格的id 给tbody里面的tr绑定一个点击事件
                $("#brandTable tbody").on("click","tr",function () {
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
                //$("#productTable").dataTable().fnDraw(false)
                var param={};//动态传参
                param.brandName=$("#brandName").val();
                param.minEntrtyTime = $("#minEntrtyTime").val();
                param.maxEntrtyTime = $("#maxEntrtyTime").val();
                param.minUpdateTime = $("#minUpdateTime").val();
                param.maxUpdateTime = $("#maxUpdateTime").val();
                brandTable.settings()[0].ajax.data=param;
                brandTable.ajax.reload();

            }
            function update(id) {
                alert(id.value);
            }
            //回显
            function findOne(id) {
                location.href="<%=request.getContextPath()%>/brand/findOne.jhtml?id="+id;
            }
            //单个删除
            function deleteOne(id) {
                alert(id)
                if(confirm("你确定删除吗？")){
                    $.ajax({
                        url:"<%=request.getContextPath()%>/brand/deleteOne.jhtml",
                        type:"post",
                        data:{"id":id},
                        dataType:"json",
                        success:function(res){

                            if(res.code==200){
                                alert("删除成功");
                                console.log(res);
                                console.log(res.msg);
                                search(1);
                            }else{
                                alert("删除失败："+res.msg);
                            }

                        }
                    })
                }
            }
            //加载表格
            var brandTable;
            function initTable() {
                brandTable=$('#brandTable').DataTable({
                    "autoWidth": true,//设置自适应宽度
                    "info": true,//展示左下角信息
                    "lengthChange": true,//是否允许改变每页条数
                    "lengthMenu": [ 3, 6, 9, 12],//设置每页条数
                    "paging": true,//是否开启分页
                    "processing": true,//页面加载慢的时候展示处理状态
                    "serverSide": true,//时候开服务器模式
                    "bFilter": false,
                    "ajax": {
                        "url": "query.jhtml",
                        "type": "POST",
                        /* "data":function (a) {
                             a.productName = $("#productName").val();
                             a.minPrice = $("#minPrice").val();
                             a.maxPrice = $("#maxPrice").val();
                             a.minEntrtyTime = $("#minCreateTime").val();
                             a.maxEntrtyTime = $("#maxCreateTime").val();
                             a.minUpdateTime = $("#minUpdateTime").val();
                             a.maxUpdateTime = $("#maxUpdateTime").val();
                         }*/
                    },
                    //重绘表单
                    "drawCallback":function (x) {
                        //获取当前页面所有复选框的值
                        $("#brandTable tbody tr input[type='checkbox']").each(function () {
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
                        {"data": "brandName",sortable : false,},
                        {
                            "data": "entrtyTime",
                            render: function (data, type, row, meta) {
                                if (data != null) {
                                    return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
                                }
                                return data;
                            }
                        },
                        {
                            "data": "updateTime",
                            render: function (data, type, row, meta) {
                                if (data != null) {
                                    return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
                                }
                                return data;
                            }
                        },
                        {
                            "data": "id",sortable : false,
                            render: function (data, type, row, meta) {
                                var buttons = '';
                                buttons += '<button type="button" id="update" onclick="findOne('+data+')" class="btn btn-xs btn-info"><span class="glyphicon glyphicon-pencil"></span>修改</button>';
                                buttons += '<button type="button" onclick="deleteOne('+data+')" class="btn btn-xs btn-danger"><span class="glyphicon glyphicon-trash"></span>删除</button>';
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
