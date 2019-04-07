<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<title>用户增加</title>
</head>
<body>
<%--<form action="<%=request.getContextPath()%>/user/add.jhtml" type="post">
用户名：<input name="userName"/></br>
密码：<input type="password" name="userPwd"/></br>
<input type="submit"/>
<input type="reset"/>
</form>--%>
<center>
    <h1>用户注册</h1>
    <form onsubmit="return checkLoginForm()" action="<%=request.getContextPath()%>/user/add.jhtml" method="post">
        <table>
            <tr>
                <td>用户名</td>
                <td><input placeholder="请至少输入3位字母数字" onblur="selectName()" name="userName" id="userName"></td>
            </tr>
            <tr>
                <td>密码</td>
                <td><input placeholder="密码只能是字母数字" type="password" id="pw1" name="userPwd"></td>
            </tr>
            <tr>
                <td>确认密码</td>
                <td><input placeholder="密码只能是字母数字" type="password" id="pw2" ></td>
            </tr>
            <tr>
                <td>真实姓名</td>
                <td><input placeholder="名字只能是中文"  id="userRealName" ></td>
            </tr>
            <tr>
                <td>生日</td>
                <td><input  id="birthday" ></td>
            </tr>
            <tr>
                <td>性别</td>
                <td><input type="radio" name="sex" value="1">男
                    <input type="radio" name="sex" value="2">女</td>
            </tr>
            <tr>
                <td>薪资要求</td>
                <td><input  id="salary" ></td>
            </tr>
            <tr>
                <td>部门</td>
                <td>
                    <select name="dept.id">
                        <option value="-1">--请选择--</option>
                      <%--  <c:forEach items="${deptList}" var="dept">
                            <option value="${dept.id}">${dept.name}</option>
                        </c:forEach>--%>

                    </select>
                </td>
            </tr>
            <tr>
                <td><input type="submit"></td>
                <td><input type="reset"></td>
            </tr>
        </table>
    </form>
</center>
<script>
    function selectName() {
        var v_name=$("#userName").val();
        $.ajax({
            url:"<%=request.getContextPath()%>/user/queryName.jhtml",
            type:"post",
            data:{"userName":v_name},
            success:function (data) {
                /* 通过JSON的parse() 方法 将json字符串转换为json对象 */
                var jsonData = JSON.parse(data);
                //alert(jsonData.res);
                if (jsonData.res==1) {
                    alert("用户名已存在,请重新输入")
                }
                else {
                    alert("该账号可以注册")
                }
            },
            error:function (data) {
                alert("增加出错")
            }
        })
    }
    //表单为空验证 正则验证
    function checkLoginForm() {
        var zmReg=/^[0-9A-Za-z]*$/; //英文数字
        var user = $("[name='userName']").val();
        var pw1 = document.getElementById("pw1");
        var pw2 = document.getElementById("pw2");
        if(user==""){
            alert("用户名不能为空");
            return false;
        }
        if(!zmReg.test(user)){
            alert("用户名格式不对，请重新输入");
            return false;
        }
        if(user.length<3){
            alert("用户名过短，请重新输入");
            return false;
        }
        if(pw1.value==""){
            alert("密码不能为空");
            return false;
        }
        if(pw2.value==""){
            alert("确认密码不能为空");
            return false;
        }
        if(pw2.value!=pw1.value){
            alert("两次密码不一致");
            return false;
        }
    }
</script>

</body>
</html>