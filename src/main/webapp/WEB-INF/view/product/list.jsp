<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/contextPath.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/shop/shop.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<!--引入css-->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/DataTables-1.10.15/media/css/jquery.dataTables.min.css">
	<!--引入JavaScript-->
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath()%>/DataTables-1.10.15/media/js/jquery.dataTables.min.js"></script>
<title>产品列表</title>
</head>
<body>
<center>
<form id="productForm" method="post">
<table border="1" width="100%" cellspacing="0">
	<tr>
	<td>商品名字</td>
	<td><input type="text" id="productName" name="productName"/></td>
	</tr>
	<tr>
	<td>商品价格</td>
	<td><input type="text" id="minPrice" name="minPrice"/>--<input type="text" id="maxPrice" name="maxPrice"/></td>
	  </tr>
	 <tr>
	<td>录入时间</td>
	<td><input type="text" id="minEntrtyTime" name="minEntrtyTime" onclick="WdatePicker()"/>--
	<input type="text" id="maxEntrtyTime" name="maxEntrtyTime" onclick="WdatePicker()"/></td>
	</tr>
	<tr>
	<td>修改时间</td>
	<td><input type="text" id="minUpdateTime" name="minUpdateTime" onclick="WdatePicker()"/>--
	<input type="text" id="maxUpdateTime" name="maxUpdateTime" onclick="WdatePicker()"/></td>
	</tr> 
	<tr>
	<td>品牌名字</td>
	<td>
	<select id="option" name="brand.id">
	<option value="-1">---请选择---</option>

	</select>
	</td>
	
	</tr>
	<tr>
	<td><input type="button" value="查询" onclick="search(1)"></td>
	<td><input type="reset"><input type="text" id="hidenid" readonly="readonly"></td>
	</tr>
	
</table>
</form>
<a href="<%=request.getContextPath()%>/product/toAdd.jhtml">增加</a>
<input type="button" onclick="deleteAll()" value="批量删除"/>
<input type="button" onclick="exportExcel()" value="导出excel"/>
<input id="ids"  readonly="readonly"/>
	<input type="button" onclick="exportBrandExcel()" value="按品牌导出excel"/>
<div id="son">
<jsp:include page="/WEB-INF/view/product/productPage.jsp"></jsp:include>
</div>
</center>

<script type="text/javascript">
	$(function () {
		$("#a").DataTable({
			//"lengthMenu": [3, 6, 9, 12],
			/*"language": {
				"lengthMenu": "每页 _MENU_ 条记录",
				"zeroRecords": "没有找到记录",
				"info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
				"infoEmpty": "无记录",
				"infoFiltered": "(从 _MAX_ 条记录过滤)"
			}*/
			"language":{
				"url":"<%=request.getContextPath()%>/DataTables-1.10.15/media/js/Chinese.json"
			}
		});
	});
	//加载函数
	$(function(){
		init();//表格变色
		initSelect("option");//加载下拉框函数
		initOrderBy();//排序函数
	})
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
//加载添加函数
function toAdd(){
	$("#addJsp").show();
}
function addProduct(){
	$("#addJsp").hide();
	var productame=$("#productame").val();
	var productprice=$("#productprice").val();
	var brandid=$("#brandid").val();
	$.ajax({
		url:"<%=request.getContextPath()%>/product/add.jhtml",
		type:"post",
		data:{
			"productName":productame,
			"productPrice":productprice,
			"brandId":brandid,
		},
		success:function(){
			search(1);
		}
	})
}

//排序函数加载
var v_dataSort;
var v_data;
function initOrderBy(){
	//找到表格中所有的input框中的button按钮
	$("#a thead input[type='button']").each(function(){
	
		
		$(this).bind("click",function(){
			
			//获得指定的标签的 元素
			 v_dataSort=$(this).attr("data-sort-field");
			 v_data=$(this).attr("data-sort");
/* 			console.log(v_dataSort);
			console.log(v_data); */
			 search(1);
			
		})
		
		if($(this).attr("data-sort-field")==v_dataSort && $(this).attr("data-sort")==v_data){
			 $(this).css("background-color","red");
		}
		else{
			$(this).bind("mouseout",function(){
				$(this).css("background-color","");
			})
			$(this).bind("mouseover",function(){
				$(this).css("background-color","green");
			})
		}
		
	})
}
//定义空数组
var v_arr=[];
//创建函数 表格变色
function init(){
	//获取子页面中表格中的行
	$("#a tbody tr").each(function(){
	
		//获取复选框
		var v_box=$(this).find("input[name='checkName']:checkbox")[0];
		//翻页回填
		for (var i = 0; i < v_arr.length; i++) {
			if(v_arr[i]==v_box.value){
				$(this).css("background","green");
				v_box.checked=true;
			}
		}
	//console.log(this);
	//对指定元素帮点事件
	$(this).bind("click",function(){
		
		//判断复选框的状态
		if(v_box.checked){
			$(this).css("background","");
			v_box.checked=false;
			$(this).attr("flag","");
			deleteIds(v_box.value);
		}else{
			$(this).css("background","green");
			v_box.checked=true;
			$(this).attr("flag","1");
			v_arr.push(v_box.value);
		}
	})
		//给指定元素绑定鼠标移上和移开事件事件
		/* $(this).bind("mouseover",function(){
			$(this).css("background-color","yellow");
		})*/
		$(this).bind("mouseout",function(){
			if($(this).attr("flag")!="1"){
				$(this).css("background-color","");
			}
		}) 
		$(this).bind("mousemove",function(){
			if($(this).attr("flag")!="1"){
				$(this).css("background-color","red");
			}
		})
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
//分页每页10条 15条
	var v_pageSize;
	function changePageSize(pageSize) {
		v_pageSize=pageSize;
		search(1);
	}
//分页ajax
function search(page) {
	var v_productName = $("#productName").val();
	var v_minPrice = $("#minPrice").val();
	var v_maxPrice = $("#maxPrice").val();
	var v_minEntrtyTime = $("#minEntrtyTime").val();
	var v_maxEntrtyTime = $("#maxEntrtyTime").val();
	var v_minUpdateTime = $("#minUpdateTime").val();
	var v_maxUpdateTime = $("#maxUpdateTime").val(); 
	var v_option=$("#option").val();
	var v_flag = $("#hidenid").val(); 
	$.ajax({
		url:"<%=request.getContextPath()%>/product/queryList.jhtml",
		type:"post",
		data:{
			"productName":v_productName,
			"minPrice":v_minPrice,
			"maxPrice":v_maxPrice,
		   "minEntrtyTime":v_minEntrtyTime,
			"maxEntrtyTime":v_maxEntrtyTime,
			"minUpdateTime":v_minUpdateTime,
			"maxUpdateTime":v_maxUpdateTime,
			"brand.id":v_option,
			"dataSort":v_dataSort,
			"data":v_data,
			"pageIndex":page,
			"pageSize":v_pageSize,
			"flag":1},
		success:function(result) {
			// 刷新
			$("#son").html(result);
			init();
			initOrderBy();
			
		}
	})
}
function turnPage(pageIndex) {
	search(pageIndex);
	
}
//修改回显
function findProduct(id){
	location.href="<%=request.getContextPath()%>/product/findProduct.jhtml?id="+id;
}
//查看图片
	function queryImages(id){
		location.href="<%=request.getContextPath()%>/product/queryImages.jhtml?id="+id;
	}
//单个删除
function deleteProduct(id){
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
//批量删除
function deleteAll(){
/* 	var v_ids="";
	$("input[name='checkName']:checkbox:checked").each(function(){
		v_ids+=","+this.value;	
	}); */
	//alert(v_ids)
	if(v_arr.length>0){
	var v_ids=v_arr.join(",");
		 if(confirm("你确定要删除吗？")){
			 $.ajax({
				url:"<%=request.getContextPath()%>/product/deleteAll.jhtml",
				type:"post",
				data:{"ids":v_ids},
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
	  else{
		  alert("请至少选择一条")
	  } 
}
/////////////////////////////////////////////////////////////////
//页面加载事件
/*  $(function(){
	brandTable();
})
 */
//点击变色
/* function brandTable(){
	//获取要变色的所有tr
	var trall=$(".trclass");
	//遍历所有的tr，
	for(var i=0;i<trall.length;i++){
		//加绑定onclick事件
		trall[i].onclick=function(){
			//判断点击时tr有没有颜色--没有颜色是进入
			if(this.style.backgroundColor!="pink"){
				//给tr赋颜色
				this.style.backgroundColor="pink";
				//从tr找到input框为checkbox框
				//为tr下的子节点
				var check=$(this).children().children();
				//让复选框被选中
				check.prop("checked",true);
				//把复选框中的值追加到隐藏框中
				$("#hidenid").val($("#hidenid").val()+check.val()+",");
				//判断点击时tr有没有颜色--有颜色是进入
				}else{
					//把tr框中的颜色变为空
					this.style.backgroundColor="";
					//从tr找到input框为checkbox框
					//为tr下的子节点
					//tr-->td-->input  为children  相当于子节点
					var check=$(this).children().children();
					//取消checkbox框的被选中的状态
					check.prop("checked",false);
					//把隐藏框中的值给取消掉
					var ids=$("#hidenid").val();
					ids=ids.replace(check.val()+",","");
					//把新获取的id替换旧的id
					$("#hidenid").val(ids);
					}
			}
		}
} */
//点击下一页颜色回显，checked回显
/* function savechecked(){
	//对隐藏框中的值进行以","切割
	var ids=$("#hidenid").val().split(",");
	//遍历隐藏框中的值
	for(var i=0;i<ids.length;i++){
		//遍历所有的input框的值（checkbox框）
		$("[name='checkName']").each(function(){
			//判断如果一致，则被选中
			if(ids[i]==$(this).val()){
				$(this).prop("checked",true);
				//再次给input框赋颜色
				//从input-->td-->tr  为parent  相当于父节点
				var check=$(this).parent().parent();
				check.get(0).style.backgroundColor="pink";
				}
			})
		}
}  */

</script>

</body>
</html>