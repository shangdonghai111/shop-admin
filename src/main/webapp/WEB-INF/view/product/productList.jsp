<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/2/27
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<html>
<head>
    <title>商品展示</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-3.3.6-dist/css/bootstrap.min.css"/>
 <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/dataTables.bootstrap.min.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css"/>
    <link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
    <link href="<%=request.getContextPath()%>/js/datetimepicker/build/build_standalone.less" rel="stylesheet" type="text/css">

    <style>
    ul li a{
        color: black;
    }
</style>
</head>
<body>
<%--<form id="form" action="" method="post" >
    <div class="text-c">
        <label>商品分类：</label>
        <span class="select-box inline" style="margin:7px">
	  		<select id="option" name="brand.id" class="select" style="width:200px">
				<option value="-1">--请选择--</option>
               &lt;%&ndash; <option value="1">--宝马--</option>
                <option value="2">--联想--</option>
                <option value="3">--奔驰--</option>
                 <option value="4">--华为--</option>
                 <option value="5">--法拉利--</option>
                <c:forEach items="${list}" var="list">
                    <option  value="${list.id}">---${list.brandName}---</option>
                </c:forEach>&ndash;%&gt;
			</select>
		</span>
        商品名称：
        <input type="text" id="productName" name="productName" placeholder="商品名称" style="width:200px" class="input-text"/>
        商品价格：
        <input type="text" id="minPrice" name="minPrice" placeholder="商品价格" style="width:200px" class="input-text"/>--
        <input type="text" id="maxPrice" name="maxPrice" placeholder="商品价格" style="width:200px" class="input-text"/>
        <button name="" id="" onclick="search()" class="btn btn-success" type="button"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
        <button class="btn btn-default" type="reset">
            <i class="glyphicon glyphicon-refresh"></i>
            重置
        </button>
    </div>
</form>--%>
<%--头部div--%>
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
<form id="productForm" class="form-horizontal" role="form">
    <fieldset>
        <legend style="background-color: #6A6AFF">条件查询</legend>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品名称</label>
            <div class="col-sm-4">
                <input class="form-control" id="productName" name="productName" type="text"/>
            </div>
            <label class="col-sm-2 control-label">商品价格</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input type="text" class="input-sm form-control" id="minPrice" name="minPrice"/>
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-yen"></i>
                            </span>
                    <input type="text" class="input-sm form-control" id="maxPrice" name="maxPrice"/>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">创建时间</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input size="16" type="text"  readonly class="input-sm form-control" id="minCreateTime">
                    <span class="input-group-addon">
                    <i class="glyphicon glyphicon-calendar"></i>
                    </span>
                    <input size="16" type="text" readonly class="input-sm form-control" id="maxCreateTime">
                </div>
            </div>
            <label class="col-sm-2 control-label">修改时间</label>
            <div class="col-sm-4">
                <div class="input-group">
                    <input size="16" type="text"  readonly class="input-sm form-control" id="minUpdateTime">
                    <span class="input-group-addon">
								<i class="glyphicon glyphicon-forward"></i>
                            </span>
                    <input size="16" type="text"  readonly class="input-sm form-control" id="maxUpdateTime">
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">商品品牌</label>
            <div class="col-sm-4">
                <select id="option" name="brand.id" class="form-control" >
                    <option value="-1">---请选择---</option>

                </select>
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
        <button style="background-color: green" class="btn btn-primary" type="button" onclick="exportExcel();">
            <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
            导出excel
        </button>
        <button style="background-color: deeppink" class="btn btn-primary" type="button" onclick="exportBrandExcel();">
            <span class="glyphicon glyphicon-download" aria-hidden="true"></span>
            按品牌导出excel
        </button>
        <button class="btn btn-primary" type="button" onclick="toAdd();">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            增加
        </button>
        <button class="btn btn-primary" type="button" onclick="deleteAll();">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
            批量删除
        </button>
    </div>
</form>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">商品列表</h3>
    </div>
    <div class="panel-body">
<table id="productTable" class="table table-condensed" style="width:100%">
    <thead>
    <tr>
        <th>商品id</th>
        <th>商品名字</th>
        <th>商品图片</th>
        <th>商品价格</th>
        <th>录入时间</th>
        <th>修改时间</th>
        <th>品牌名字</th>
        <th>操作</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>商品id</th>
        <th>商品名字</th>
        <th>商品图片</th>
        <th>商品价格</th>
        <th>录入时间</th>
        <th>修改时间</th>
        <th>品牌名字</th>
        <th>操作</th>
    </tr>
    </tfoot>
</table>
    </div>
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

<script>
    $(document).ready(function () {
        initTable();//加载表格
        search();//条件查询
        initBind();//加载所有绑定事件
        initSelect("option");//加载下拉框函数
        initDate();

    });
    //加载时间
    function initDate() {
     $("#minUpdateTime").datetimepicker({
         format: 'yyyy-mm-dd hh',
         language: 'zh-CN',
         clearBtn:true,//清除按钮
        })
        $("#maxUpdateTime").datetimepicker({
            format: 'yyyy-mm-dd hh',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })
        $("#maxCreateTime").datetimepicker({
            format: 'yyyy-mm-dd hh',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })
        $("#minCreateTime").datetimepicker({
            format: 'yyyy-mm-dd hh',
            language: 'zh-CN',
            clearBtn:true,//清除按钮
        })
    }
    //批量删除
    function deleteAll(){
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
                            url:"<%=request.getContextPath()%>/product/deleteAll.jhtml",
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
    //增加
    function toAdd() {
        location.href="<%=request.getContextPath()%>/product/toAdd.jhtml";
    }
    //导出excel
    function exportExcel() {
        //用js动态提交form表单,将前台参数传递到后台
        var productForm = document.getElementById("productForm");
        productForm.action="<%=request.getContextPath()%>/product/exportExcel.jhtml";
        productForm.submit();
    }
    //按品牌导出excel
    function exportBrandExcel() {
        //用js动态提交form表单,将前台参数传递到后台
        var productForm = document.getElementById("productForm");
        productForm.action="<%=request.getContextPath()%>/product/exportBrandExcel.jhtml";
        productForm.submit();
    }
    //创建绑定事件
    //定义空数组
    var v_arr=[];
    function initBind() {
        //通过表格的id 给tbody里面的tr绑定一个点击事件
    $("#productTable tbody").on("click","tr",function () {
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
        param.productName=$("#productName").val();
        param.minPrice=$("#minPrice").val();
        param.maxPrice=$("#maxPrice").val();
        param.minEntrtyTime = $("#minCreateTime").val();
        param.maxEntrtyTime = $("#maxCreateTime").val();
        param.minUpdateTime = $("#minUpdateTime").val();
        param.maxUpdateTime = $("#maxUpdateTime").val();
        param["brand.id"] = $("#option").val();
        productTable.settings()[0].ajax.data=param;
        productTable.ajax.reload();
    }
function update(id) {
alert(id.value);
}
    //加载表格
    var productTable;
function initTable() {
    productTable=$('#productTable').DataTable({
        "autoWidth": true,//设置自适应宽度
        "info": true,//展示左下角信息
        "lengthChange": true,//是否允许改变每页条数
        "lengthMenu": [ 5, 10, 15, 30, 45],//设置每页条数
        "paging": true,//是否开启分页
        "processing": true,//页面加载慢的时候展示处理状态
        "serverSide": true,//时候开服务器模式
        "bFilter": false,
        "ajax": {
            "url": "queryList.jhtml",
            "type": "POST",
            //用于处理服务器端返回的数据。 dataSrc是DataTable特有的
            "dataSrc":function (result) {
                if (result.code==200){
                    result.draw=result.data.draw;
                    result.recordsTotal=result.data.recordsTotal;
                    result.recordsFiltered=result.data.recordsFiltered;
                    return result.data.data;
                }
            }
           /* "data":function (a) {
                a.productName = $("#productName").val();
                a.minPrice = $("#minPrice").val();
                a.maxPrice = $("#maxPrice").val();
                a.minEntrtyTime = $("#minCreateTime").val();
                a.maxEntrtyTime = $("#maxCreateTime").val();
                a.minUpdateTime = $("#minUpdateTime").val();
                a.maxUpdateTime = $("#maxUpdateTime").val();
                a.brandId = $("#option").val();
            }*/
        },
        "order": [[3, "desc"]],
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
        "order": [[0, "desc"]],
        "columns": [
            {
                "data": "id",
                render: function (data, type, row, meta) {
                    return "<input type='checkbox' value='" + data + "' name='checkName' id='productTable'>";
                }
            },
            {"data": "productName",sortable : false},
            {
                "data": "productImage",sortable : false,
                render: function (data, type, row, meta) {
                    return "<img src='" + data + "' width='50px' height='50px' height='50px'/>"
                }
            },
            {"data": "productPrice"},
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
            {"data": "brand.brandName",sortable : false},
            {
                "data": "id",sortable : false,
                render: function (data, type, row, meta) {
                    var buttons = '';
                    buttons += '<button type="button"  id="update" onclick="findOne('+data+')" class="btn btn-xs btn-info"><span class="glyphicon glyphicon-pencil"></span>修改</button>';
                    buttons += '<button type="button" value="data" onclick="queryImages('+data+')" style="background-color: blue" class="btn btn-xs btn-info"><span class="glyphicon glyphicon-th"></span>查看子图片</button>';
                    buttons += '<button type="button" id="btn_delete" value="data" onclick="deleteOne('+data+')" class="btn btn-xs btn-danger"><span class="glyphicon glyphicon-trash"></span>删除</button>';
                    return buttons;
                }
            },


        ],
        "language": {
            "url": "<%=request.getContextPath()%>/DataTables-1.10.15/media/js/Chinese.json"
        },

    });
}

    //$(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh'});

//查看子图片
    function queryImages(id) {
        location.href="<%=request.getContextPath()%>/product/queryImages.jhtml?id="+id;
    }
//回显
    function findOne(id) {
        location.href="<%=request.getContextPath()%>/product/findProduct.jhtml?id="+id;
    }
    //单个删除
    function deleteOne(id) {
        alert(id)
        if(confirm("你确定删除吗？")){
            $.ajax({
                url:"<%=request.getContextPath()%>/product/deleteProduct.jhtml",
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

</script>
</body>
<%--<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>--%>
<%--<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>--%>
<%--  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css"/>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
  <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css"/>--%>
</html>
