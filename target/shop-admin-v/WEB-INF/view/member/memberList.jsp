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
    <title>会员列表</title>
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
        <h3 class="panel-title">会员列表</h3>
    </div>
    <div class="container-fluid" id="vipList">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>用户名称</th>
                <th>手机号码</th>
                <th>用户邮箱</th>
                <th>用户生日</th>
                <th>地址</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
            <tfoot>
            <tr>
                <th>ID</th>
                <th>用户名称</th>
                <th>手机号码</th>
                <th>用户邮箱</th>
                <th>用户生日</th>
                <th>地址</th>
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
        initMember();

    });
    //回显
    function findOne(id) {
        location.href="<%=request.getContextPath()%>/member/findOne.jhtml?id="+id;
    }
    function initMember() {
        $.ajax({
            type:"post",
            url:"/member/queryMemberList.jhtml",
            success:function (result) {
                console.log(result)
                if (result.code == 200) {
                    var v_data = result.data;
                    for (var i = 0; i < v_data.length; i++) {
                        var v_memberAPI = result.data;
                        for (var i = 0; i < v_memberAPI.length; i++) {
                            var mem=v_memberAPI[i];
                            var api = " <tr>\n" +
                                "        <td>"+mem.id+"</td>\n" +
                                "        <td>"+mem.userName+"</td>\n" +
                                "        <td>"+mem.phone+"</td>\n" +
                                "        <td>"+mem.email+"</td>\n" +
                                "        <td>"+mem.birthday+"</td>\n" +
                                "        <td>"+mem.cityName+"</td>\n" +/*"+mem.sheng+""+mem.shi+""+mem.xian+"*/
                                "        <td><input type='button' value='修改' onclick='findOne("+mem.id+")'/></td>\n" +
                                "    </tr>"

                            $("#tbody").append(api);

                        }
                    }
                }
            }
        })
    }

</script>

</body>
</html>
