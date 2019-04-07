<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/3/20
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员修改</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<form  class="form-horizontal">
    <fieldset style="text-align: center">
        <legend style="font-size: 30px;color: deeppink">修改会员</legend>

        <div  class="form-group">
            <div class="col-sm-3"></div>
            <label for="brandName" class="col-sm-2 control-label">用户名字：</label>
            <div class="col-sm-2">
                <input type="hidden" id="memId" name="id" readonly="readonly" value="${member.id}"></br>
                <input disabled="disabled" type="text" class="form-control" id="brandName" value="${member.userName}" name="brandName" >
            </div>
        </div>
        <div  class="form-group">
            <div class="col-sm-3"></div>
            <label for="brandName" class="col-sm-2 control-label">邮箱：</label>
            <div class="col-sm-2">
                <input type="text" class="form-control" id="email" value="${member.email}" name="email" >
            </div>
        </div>
        <div  class="form-group">
            <div class="col-sm-3"></div>
            <label for="birthday" class="col-sm-2 control-label">生日：</label>
            <div class="col-sm-2">
                <input onclick="WdatePicker({skin:'whyGreen'})" class="form-control" id="birthday" value="${member.birthday}" name="birthday" >
            </div>
        </div>
        <div  class="form-group">
            <div class="col-sm-3"></div>
            <label for="birthday" class="col-sm-2 control-label">详细地址：</label>
            <div class="col-sm-2">
                <input disabled="disabled" class="form-control" id="cityName" value="${member.cityName}" name="cityName" >
            </div>
        </div>
        <div  class="form-group" id="selectDiv">
            <div class="col-sm-3"></div>
            <label  class="col-sm-2 control-label">请选择地址：</label>

        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-5">
                <div class="col-sm-4"></div>
                <button type="submit"  class="btn btn-default" onclick="updateMember()">提交</button>
                <button type="reset" class="btn btn-default">重置</button>

            </div>
        </div>
    </fieldset>
</form>

<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/dataTables.bootstrap.min.js"></script>
<script>
    $(function () {
        initArea(0);
    })
    //加载下拉框
    function initArea(id,obj) {
        $.ajax({
            dataType:"jsonp",
            url:"http://192.168.1.18:8080/area/queryAreaList.jhtml",
            data:{"id":id},
            success:function (result) {
                if (result.code==200){
                    if (obj){
                        //删除同级元素
                        $(obj).parent().nextAll().remove();
                    }
                    //如果后面没有子元素就不需要在拼接
                    if (result.data.length==0){
                        return;
                    }
                    var v_select="<div class=\"col-sm-2\">\n" +
                        "         <select class=\"form-control\" name='areaSelect' onchange='initArea(this.value,this)'><option value='-1'>--请选择--</option>";

                    for (var i=0;i<result.data.length;i++){
                        var v_item=result.data[i];
                        v_select+="<option value='"+v_item.id+"'>"+v_item.cityName+"</option>";

                    }

                    v_select+="  </select>\n" +
                        "          </div>";

                    $("#selectDiv").append(v_select);



                }
            }
        })
    }
    //修改
    function updateMember() {

        var infos="";
        var v_cityIds="";
        $("select[name='areaSelect']").each(function () {
            infos+=this.options[this.selectedIndex].text;
            v_cityIds+=","+this.value;
        });
        v_cityIds=v_cityIds.substring(1);
      alert(v_cityIds);
        var id=$("#memId").val();
        var email=$("#email").val();
       var birthday=$("#birthday").val();
        alert(id+email+birthday);
        $.ajax({
            data:{
                "id":id,
                "email":email,
                "birthday":birthday,
                "cityIds":v_cityIds,
                "cityName":infos
            },
            url:"<%=request.getContextPath()%>/member/update.jhtml",
            success:function (res) {
                if (res.code==200){
                    alert("修改成功")
                }
            }

        })
    }
</script>

</body>
</html>
