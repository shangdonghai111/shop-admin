<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>品牌查询页面</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/My97DatePicker/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
	<!--引入JavaScript-->
	<script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script
</head>
<body>
<form>
品牌名字:<input id="brandName"><br/>
录入时间:<input type="text" id="minEntrtyTime" onclick="WdatePicker()"/>--
	<input type="text" id="maxEntrtyTime" onclick="WdatePicker()"/><br/>
修改时间<input type="text" id="minUpdateTime" onclick="WdatePicker()"/>--
	<input type="text" id="maxUpdateTime" onclick="WdatePicker()"/><br/>
<input type="button" value="查询" onclick="serach(1)"/>
<input type="reset">
</form></br>

<a href="<%=request.getContextPath()%>/brand/toAdd.jhtml">增加</a>
<input type="button" value="批量删除" onclick="deleteAll()"/><br/>

<input type="button" value="增加" onclick="addBrand()"/>
<div id="div" style="display: none">
品牌名字:<input type="text" id="v_BrandName"/>
<input type="button" value="保存" onclick="add()"/>
<input type="button" value="取消" onclick="reset()"/>
</div>
<!-- 子jsp -->
<div id="zi">
<jsp:include page="/WEB-INF/view/brand/brandPage.jsp"></jsp:include>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#ziTr').DataTable({
			"pagingType":   "full_numbers"
		});
	});
//修改取消
function noSave(id){
	//当点击修改取消的按钮时把原来查询页面的字段的div显示并禁用修改回显该字段的那个div
	$("#update"+id).css("display","none");
	$("#select"+id).css("display","");	
}
//编辑
function findBrand(id){
	//通过td里面自定义的属性，获取里面的值
	var v_brandName=$("td[data-id='"+id+"']").attr("data-brandName");
	//通过td里面自定义属性给td赋值
	$("td[data-id='"+id+"']").html("<input id='v_brandId_"+id+"' value='"+v_brandName+"'/><input type='button' value='保存' onclick='save(\""+id+"\",\""+v_brandName+"\")'/><input type='button' value='取消' onclick='quxiao(\""+id+"\",\""+v_brandName+"\")'/>");
}
//取消函数
function quxiao(brandId,brandName){
	$("td[data-id='"+brandId+"']").html(brandName);
}
//编辑保存
function save(id){
	
	var v_name=$("#v_brandId_"+id).val();
	//alert(v_name);
	$.ajax({
		url:"<%=request.getContextPath()%>/brand/updateBland.jhtml",
		type:"post",
		data:{
			"id":id,
			"brandName":v_name,
		},
		success:function(res){
			if(res.code==200){
				alert("修改成功");
				//把td里面重新赋值 并把属性也重新赋值
				$("td[data-id='"+id+"']").html(v_name);
				$("td[data-id='"+id+"']").attr("data-brandName",v_name);
				
			}else{
				alert(res.msg);
			}
			
			
		}
	})
}
//取消
function reset(){
	$("#div").css("display","none");
	location.href="<%=request.getContextPath()%>/brand/query.jhtml";
}
//增加
function addBrand(){
	$("#div").css("display","");
}
function add(){
	$("#div").css("display","none");
	var v_name=$("#v_BrandName").val();
	  if(v_name==""){
	    	alert("品牌名不能为空");
	        return false;
	    }
		$.ajax({
			url:"<%=request.getContextPath()%>/brand/add.jhtml",
			type:"post",
			data:{
				"brandName":v_name,
			},
			success:function(res){
				serach(1);
			}
		})
	
}
//分页
function serach(page){
	var v_name=$("#brandName").val();
	var v_minEntrtyTime = $("#minEntrtyTime").val();
	var v_maxEntrtyTime = $("#maxEntrtyTime").val();
	var v_minUpdateTime = $("#minUpdateTime").val();
	var v_maxUpdateTime = $("#maxUpdateTime").val(); 
	$.ajax({
		url:"<%=request.getContextPath()%>/brand/query.jhtml",
		type:"post",

		data:{
			"brandName":v_name,
			"minEntrtyTime":v_minEntrtyTime,
			"maxEntrtyTime":v_maxEntrtyTime,
			"minUpdateTime":v_minUpdateTime,
			"maxUpdateTime":v_maxUpdateTime, 
			"pageIndex":page,
			"flag":1,
			"dataSort":v_dataSort,
			"data":v_data,
		},
		success:function(res){
			//刷新
			$("#zi").html(res);
			init();//加载表格e变色函数
			initOrderBy();//重新加载动态绑定事件
			//翻页回显 给按钮重新赋颜色（防止多个按钮同时点击有颜色）
			if(v_data_button_id){
				$("input[type='button'][data-sort-button='"+v_data_button_id+"']").css("background","red");
			}
		}
	})
}
//上下分页跳转
function turnPage(pageIndex){
	serach(pageIndex);
}
//单个删除
function deleteOne(id){
	if(confirm("你确定删除吗？")){
	$.ajax({
		url:"<%=request.getContextPath()%>/brand/deleteOne.jhtml",
		type:"post",
		data:{"id":id},
		dataType:"json",
		success:function(res){
			if(res.code==200){
				alert("删除成功");
				serach(1);
			}else{
				alert(res.msg+";"+res);
			}
			
		}
	})
	}
}
//修改
function findOne(id){
	location.href="<%=request.getContextPath()%>/brand/findOne.jhtml?id="+id;
}
//删除多个
function deleteAll(){//
	/* var box="";
	$("input[name='checkName']:checkbox:checked").each(function(){
		box+=","+this.value;
	});//alert(box); */
	if(v_idsArr.length>0){
		var box= v_idsArr.join(",");
		console.log(box);
		if(confirm("你确定删除吗?")){
			$.ajax({
				url:"<%=request.getContextPath()%>/brand/deleteAll.jhtml",
				type:"post",
				data:{"ids":box},
				success:function(res){
					console.log(res);
					if(res.code==200){
						alert("删除成功");
						serach(1);
					}else{
						alert(res);
					}
					
				}
			})
		}
	}else{
		alert("请至少选择一条!")
	}

}//
</script>

<script type="text/javascript">
//加载函数
$(function(){
	init();//表格变色函数
	initOrderBy();//排序函数
});
//排序函数
var v_dataSort;
var v_data;//通过全局变量把指定标签中的元素通过分页ajax中的data传给实体类中定义的属性，并传递给sql语句判断排序
var v_data_button_id;
function initOrderBy(){
	//通过子页面表格中的id和thead标签查找button按钮并循环
	var i=0;
	$("#ziTr thead input[type='button']").each(function(){
		////////第一种写法  简单
		/* if($(this).attr("data-sort-field")==v_dataSort &&$(this).attr("data-sort")==v_data){
			$(this).css("background-color","red")
		}else{
			$(this).bind("mouseout",function(){
				$(this).css("background-color","")
			})
			$(this).bind("mouseover",function(){
				$(this).css("background-color","blue")
			})
		} */
		$(this).attr("data-sort-button",i);
		i++;
		//给指定按钮绑定事件
		$(this).bind("click",function(){
			//获取指定标签的元素
			 v_dataSort=$(this).attr("data-sort-field");
			 v_data=$(this).attr("data-sort");
			//console.log(v_dataSort+";"+v_data);
			//在点击事件中给选中的按钮赋颜色
			$(this).css("background","red");
			//给指定的按钮的自定义属性赋值
			v_data_button_id=$(this).attr("data-sort-button");
			//加载分页查询
			 serach(1);
		})
		//给指定按钮动态添加鼠标移上和移动事件
		$(this).bind("mouseout",function(){
			//判断自定义属性的值和传过去的值相等 意思就是有值有状态就不能改变原有的状态和颜色
			if(v_data_button_id==$(this).attr("data-sort-button")){
				return;
			}
				$(this).css("background-color","")
			})
			$(this).bind("mouseover",function(){
				//判断自定义属性的值和传过去的值相等 意思就是有值有状态就不能改变原有的状态和颜色
				if(v_data_button_id==$(this).attr("data-sort-button")){
					return;
				}
				$(this).css("background-color","blue")
			})
	})
}
//定义空数组
var v_idsArr=[];
//定义函数
function init(){
	//动态获取子页面中表格中的行
	$("#ziTr tbody tr").each(function(){
		//console.log(this);
		//获取复选框
			var v_checkbox=$(this).find("input[name='checkName']:checkbox")[0];
		//翻页回填
		for (var i = 0; i < v_idsArr.length; i++) {
			if(v_idsArr[i]==v_checkbox.value){
				$(this).css("background","pink");
				v_checkbox.checked=true;
			}
		}
		//给行绑定事件
		$(this).bind("click",function(){
			//判断复选框状态，并给行赋值
			if(v_checkbox.checked){
				$(this).css("background","");
				v_checkbox.checked=false;
				$(this).attr("flag","");
				deleteArr(v_checkbox.value);
				
			}else{
				$(this).css("background","pink");
				v_checkbox.checked=true;
				$(this).attr("flag","1");
				v_idsArr.push(v_checkbox.value);
			}
		})
		$(this).bind("mouseover",function(){
			if($(this).attr("flag")!=1){
				$(this).css("background","green");
			}
		})
		$(this).bind("mouseout",function(){
			if($(this).attr("flag")!=1){
				$(this).css("background","");
			}
		})
	})
}
//定义删除函数
function deleteArr(id){
	for (var i = v_idsArr.length-1; i >=0; i--) {
		if(v_idsArr[i]==id){
			//删除数组中的值
			v_idsArr.splice(i,1);
		}
	}
}
</script>
</body>
</html>