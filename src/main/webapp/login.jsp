<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
</head>
<body style="background-color: palegreen">
<%--<table id="table1" class="table table-condensed">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Score</th>
    </tr>
    </thead>
    <tbody><tr>
        <td>001</td>
        <td>zhang</td>
        <td>98</td>
    </tr>
    <tr>
        <td>002</td>
        <td>wang</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
    <tr>
        <td>003</td>
        <td>li</td>
        <td>99</td>
    </tr>
</table>
<script type="">
    $(function () {
        $("#table1").DataTable({
            "lengthMenu": [1, 2, 3, 4,5],
        });
    });
</script>--%>

<form class="form-horizontal">
    <fieldset style="text-align: center">
        <legend style="font-size: 30px;color: deeppink">登录页面</legend>

    <div  class="form-group">
        <div class="col-sm-3"></div>
        <label for="userName" class="col-sm-2 control-label">用户名：</label>
        <div class="col-sm-2">
            <input type="email" class="form-control" id="userName" value="admin" placeholder="Email">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3"></div>
        <label for="userPwd" class="col-sm-2 control-label">密码：</label>
        <div class="col-sm-2">
            <input type="password" id="userPwd" value="admin" class="form-control"  placeholder="Password">
        </div>
    </div>
        <div class="form-group">
            <div class="col-sm-3"></div>
            <label for="imageCodeInfo" class="col-sm-2 control-label">验证码：</label>
            <img class="col-sm-1" src="<%=request.getContextPath()%>/imageCode" id="imageCodeInfo">
            <a class="col-sm-1" href="javascript:;" onclick="referImageCode()">刷新</a>
            <div class="col-sm-2">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-3"></div>
            <label for="imageCode" class="col-sm-2 control-label">输入验证码：</label>
            <div class="col-sm-2">
                <input type="text" id="imageCode"  class="form-control"  placeholder="imageCode">
            </div>
        </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-5">
            <div class="col-sm-4"></div>
            <button type="button" onclick="save()" class="btn btn-default">登录</button>
            <button type="reset" class="btn btn-default">重置</button>
            <button type="button" onclick="zhuce()" class="btn btn-default">注册</button>
        </div>
    </div>
    </fieldset>
</form>
<center>
<%--<form action="">
    <table  width="260" height="200" cellspacing="0">
        <tr>
            <td colspan="2"><center><font color="blue" size="6">用户登录</font></center></td>
        </tr>
        <tr>
            <td>用户名：</td>
            <td><input id="userName" value="admin"/></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input type="password" id="userPwd" value="admin"/></td>
        </tr>
        <tr>
            <td>验证码：</td>
            <td>
                <img src="<%=request.getContextPath()%>/imageCode" id="imageCodeInfo">
                <a href="javascript:;" onclick="referImageCode()">刷新</a>
            </td>
        </tr>
        <tr>
            <td>验证码：</td>
            <td>
               <input id="imageCode"/>
            </td>
        </tr>
        <tr>
            <td><input type="button" value="登录" onclick="save()"/></td>
            <td><input type="reset"/>
            <a href="<%=request.getContextPath()%>/user/toAdd.jhtml">注册</a>
            </td>
        </tr>
    </table>




</form>--%>
</center>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/md5.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>

<script type="text/javascript">
    //注册
    function zhuce() {
        location.href="<%=request.getContextPath()%>/user/toAdd.jhtml";
    }
    //刷新
    function referImageCode() {
        var t=new Date().getTime();
        $("#imageCodeInfo").attr("src","<%=request.getContextPath()%>/imageCode?"+t);
    }
    function save(){
        var v_userName=$("#userName").val();
        var v_userPwd=hex_md5($("#userPwd").val());
        var v_imageCode=$("#imageCode").val();

        if(v_userName==null ||v_userName.length<1){
            alert("请输入用户名");
            return false;
        }
        if(v_userPwd==null ||v_userPwd.length<1){
            alert("请输入密码");
            return false;
        }
        if(v_imageCode==null ||v_imageCode.length<1){
            alert("请输入验证码");
            return false;
        }
        $.ajax({
            url:"<%=request.getContextPath()%>/user/login.jhtml",
            type:"post",
            data:{
                "userName":v_userName,
                "userPwd":v_userPwd,
                "imageCode":v_imageCode
            },
            success:function(res){
                if(res.code==200){
                    console.log(res);
                    location.href="<%=request.getContextPath()%>/product/toProductList.jhtml";
                }
                if (res.code==105){
                    alert(res.msg);

                }
                else{
                    alert(res.msg);
                    console.log(res);
                }

            }
        })
    }
</script>
</body>
</html>