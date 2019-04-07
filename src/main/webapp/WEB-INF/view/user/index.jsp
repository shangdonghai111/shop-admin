<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
    <script type="javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-1.11.3.min.js"></script>
    <script type="javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/font-awesome.min.css"/>
    <style type="text/css">


    </style>
</head>
<body>
<%--主div--%>
<div>
    <%--头部div--%>
    <div id="navbar" class="collapse navbar-collapse" style="background-color:#5e5e5e;width: 100%;height: 60px">
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="#">金科教育</a></li>
            <li role="presentation"><a href="#">校园风采</a></li>
            <li role="presentation"><a href="#">师资团队</a></li>
            <li role="presentation"><a href="#">明星学员</a></li>
            <li role="presentation"><a href="#">java课程</a></li>
        </ul>
    </div>
        <%--头部下面的大div 里面包含两个小的div--%>
        <div style="width: 100%;height: 1000px">
            <%--左边菜单栏的div--%>
            <div style="width: 20%;height: 300px;float: left">
                <%--<div class="panel panel-default" style="margin:0;">--%>
                   <%-- <div class="panel-heading">
                        <a href="#userMeun" data-parent="#accordion"  data-toggle="collapse">
                            <i class="icon-user-md icon-large"></i> 用户管理</a>
                    </div>
                    <ul >
                        <li><a href="#"><i class="icon-user"></i> 增加用户</a></li>
                        <li><a href="#"><i class="icon-edit"></i> 修改用户</a></li>
                        <li><a href="#"><i class="icon-trash"></i> 删除用户</a></li>
                        <li><a href="#"><i class="icon-list"></i> 用户列表</a></li>
                    </ul>
                </div>
                <div class="panel panel-default" style="margin:0;">

                    <div class="panel-heading">
                        <a href="#userMeun2"  data-parent="#accordion" data-toggle="collapse"><i class="icon-user-md icon-large"></i> 产品管理</a>
                    </div>

                    <ul >
                        <li><a href="#"><i class="icon-user"></i> 增加用户</a></li>
                        <li><a href="#"><i class="icon-edit"></i> 修改用户</a></li>
                        <li><a href="#"><i class="icon-trash"></i> 删除用户</a></li>
                        <li><a href="#"><i class="icon-list"></i> 用户列表</a></li>

                    </ul>
                </div>

                <div class="panel panel-default" style="margin:0;">

                    <div class="panel-heading">
                        <a href="#userMeun3"  data-parent="#accordion" data-toggle="collapse"><i class="icon-user-md icon-large"></i> 日志管理</a>
                    </div>

                    <ul >
                        <li><a href="#"><i class="icon-user"></i> 增加用户</a></li>
                        <li><a href="#"><i class="icon-edit"></i> 修改用户</a></li>
                        <li><a href="#"><i class="icon-trash"></i> 删除用户</a></li>
                        <li><a href="#"><i class="icon-list"></i> 用户列表</a></li>

                    </ul>
                </div>--%>
                       <div class="list-group">
                           <a href="#" class="list-group-item active">用户管理</a>
                           <a href="#" class="list-group-item">增加用户</a>
                           <a href="#" class="list-group-item">修改用户</a>
                           <a href="#" class="list-group-item">删除用户</a>
                           <a href="#" class="list-group-item">用户列表</a>
                       </div>

                       <div class="list-group">
                           <a href="#" class="list-group-item active">
                               产品管理
                           </a>
                           <a href="#" class="list-group-item">增加产品</a>
                           <a href="#" class="list-group-item">修改产品</a>
                           <a href="#" class="list-group-item">删除产品</a>
                           <a href="" class="list-group-item">产品列表</a>
                       </div>
                       <div class="list-group">
                           <a href="#" class="list-group-item active">
                               品牌管理
                           </a>
                           <a href="#" class="list-group-item">增加品牌</a>
                           <a href="#" class="list-group-item">修改品牌</a>
                           <a href="#" class="list-group-item">删除品牌</a>
                           <a href="#" class="list-group-item">品牌列表</a>
                       </div>

                      <%-- <div class="list-group">
                           <a href="#" class="list-group-item active">
                               日志管理
                           </a>
                           <a href="#" class="list-group-item">增加日志</a>
                           <a href="#" class="list-group-item">修改日志</a>
                           <a href="#" class="list-group-item">删除日志</a>
                           <a href="#" class="list-group-item">日志列表</a>
                       </div>--%>
            </div>

                <%--右边配置数据源的大div--%>
            <div style="width: 80%;height: 300px;float: left">

                <div class="col-sm-12">
                    <form class="form-horizontal" role="form">
                        <fieldset>
                            <legend>配置数据源</legend>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="ds_host">主机名</label>
                                <div class="col-sm-4">
                                    <input class="form-control" id="ds_host" type="text" placeholder="192.168.1.161"/>
                                </div>
                                <label class="col-sm-2 control-label" for="ds_name">数据库名</label>
                                <div class="col-sm-4">
                                    <input class="form-control" id="ds_name" type="text" placeholder="msh"/>
                                </div>


                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" >用户名</label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <input type="text" class="input-sm form-control" name="start" />
                                        <span class="input-group-addon">
								<i class="glyphicon glyphicon-calendar"></i>
								</span>
                                        <input type="text" class="input-sm form-control" name="end" />
                                    </div>
                                </div>
                                <label class="col-sm-2 control-label" for="ds_password">密码</label>
                                <div class="col-sm-4">
                                    <input class="form-control" id="ds_password" type="password" placeholder="123456"/>
                                </div>
                            </div>
                        </fieldset>

                        <div class="clearfix form-actions" style="text-align:center">

                            <button class="btn btn-primary" type="button">
                                <i class="glyphicon glyphicon-ok"></i>
                                Submit
                            </button>
                            <button class="btn btn-default" type="reset">
                                <i class="glyphicon glyphicon-refresh"></i>
                                Reset
                            </button>

                        </div>
                    </form>
                    <br/>
                    <div style="background:#d8d8d8;text-align:right;">
                        <button type="button" class="btn btn-info">
                            <span class="glyphicon glyphicon-plus"></span>
                            添加用户</button>

                        <button type="button" class="btn btn-danger">
                            <span class="glyphicon glyphicon-remove"></span>
                            批量删除</button>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading ">
                            产品信息
                        </div>

                        <div class="table-responsive">

                            <table class="table table-hover table-bordered">
                                <thead>
                                <tr>
                                    <th>选择</th>
                                    <th>产品名</th>
                                    <th>品牌</th>
                                    <th>价格</th>
                                    <th>商品图片</th>
                                    <th>创建时间</th>
                                    <th>修改时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>奔弛顶级跑车</td>
                                    <td>奔弛</td>
                                    <td>1800000</td>
                                    <td>没有</td>
                                    <td>2019-2-34</td>
                                    <td>2019-2-23</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-xs btn-info ">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                                修改
                                            </button>

                                            <button class="btn btn-xs btn-danger">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>奔弛顶级跑车</td>
                                    <td>奔弛</td>
                                    <td>1800000</td>
                                    <td>没有</td>
                                    <td>2019-2-34</td>
                                    <td>2019-2-23</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-xs btn-info ">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                                修改
                                            </button>

                                            <button class="btn btn-xs btn-danger">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>奔弛顶级跑车</td>
                                    <td>奔弛</td>
                                    <td>1800000</td>
                                    <td>没有</td>
                                    <td>2019-2-34</td>
                                    <td>2019-2-23</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-xs btn-info ">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                                修改
                                            </button>

                                            <button class="btn btn-xs btn-danger">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>奔弛顶级跑车</td>
                                    <td>奔弛</td>
                                    <td>1800000</td>
                                    <td>没有</td>
                                    <td>2019-2-34</td>
                                    <td>2019-2-23</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-xs btn-info ">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                                修改
                                            </button>

                                            <button class="btn btn-xs btn-danger">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox"></td>
                                    <td>奔弛顶级跑车</td>
                                    <td>奔弛</td>
                                    <td>1800000</td>
                                    <td>没有</td>
                                    <td>2019-2-34</td>
                                    <td>2019-2-23</td>
                                    <td>
                                        <div class="btn-group">
                                            <button class="btn btn-xs btn-info ">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                                修改
                                            </button>

                                            <button class="btn btn-xs btn-danger">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                删除
                                            </button>
                                        </div>
                                    </td>
                                </tr>

                            </table>
                            <nav>
                                <ul class="pagination">
                                    <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                    <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">4</a></li>
                                    <li><a href="#">5</a></li>
                                    <li><a href="#">6</a></li>
                                </ul>
                            </nav>

                        </div>


                    </div>
                </div>
            </div>
        </div>
</div>
<%--<center>
    <table height="400"  width="300px" cellspacing="0">
        <tr>
            <td>
                <font size="5">尊敬的会员 </font>
                <font style="size:20px;color: red">${sessionScope.user.userName}</font><font >您好!</font>
            </td>
        </tr>
        <tr>
            <td>您今天登陆了
                <font style="size:20px;color: red">${sessionScope.user.count}</font>次</td>
        </tr>
        <tr>
            <td>上次登陆时间为:</td>
        </tr>
        <tr>
            <td>
                <font style="size:20px;color: red">
                    <f:formatDate  value="${user.loginTime}" pattern="yyyy-MM-dd HH:mm:ss" type="date"></f:formatDate>
                </font>
            </td>
        </tr>
        <tr>
            <td><a href="<%=request.getContextPath()%>/product/queryList.jhtml">商品查询</a></td>
        </tr>
        <tr>
            <td><a href="<%=request.getContextPath()%>/brand/query.jhtml">品牌查询</a></td>
        </tr>

    </table>
</center>--%>
</body>
</html>