function initSelect(optionId,selectId){
//括号里面的至就是接的参数 optionId 相当于回显传过来的   selectId相当于每一个下拉框的值的id传过来
	$.ajax({
		url:contextPath+"/brand/queryBrand.jhtml",
		type:"post",
		success:function(res){
			console.log(res);
			var v_res=res.data;
			for (var i = 0; i < v_res.length; i++) {
				$("#"+optionId).append("<option value='"+v_res[i].id+"'>"+v_res[i].brandName+"</option>");
				//#相当于id选择器 拼接的是回显的传过来的值 
			}
		if(selectId){//如果有传过来的值   就把值拼接给回显的下拉框
			$("#"+optionId).val(selectId);
		}
		}
	})
}