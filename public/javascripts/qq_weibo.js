//批量获取用户相关信息
function qq_statuses_by_name(name){
  var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/qq_weibo/" + name;
  $("#loading_pane").removeClass("hide");
		$.ajax({
			type: 'POST',
			url: strurl,
			contentType: 'multipart/form-data',
			datatype: 'json',
			success:function(data)
			{
				$("#qq_curret_info_pane").html(data);
    $("#loading_pane").addClass("hide");
			},
			error:function(xhr,r,e)
			{
				alert(e);
    $("#loading_pane").addClass("hide");
			}
		});
}
//搜索
function qq_statuses_search(s_class,value){
  var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var method_name = "search_user";
		if(s_class=="人物")
		  method_name = "search_user";
		else if(s_class=="微博")
		  method_name = "search_t";
		else if(s_class=="话题")
		  method_name = "search_ht";
		  
		var strurl = strprotocol + "//" + strhost + "/qq_weibo/" + method_name;
  $("#loading_pane").removeClass("hide");
		$.ajax({
			type: 'POST',
			url: strurl,
			data:{"value":value},
			contentType: 'multipart/form-data',
			datatype: 'json',
			success:function(data)
			{
				$("#qq_curret_info_pane").html(data);
				$("#qq_"+name+"_tab").addClass("active");
    $("#loading_pane").addClass("hide");
			},
			error:function(xhr,r,e)
			{
				alert(e);
    $("#loading_pane").addClass("hide");
			}
		});
}
//发布微博
function qq_t_add(content){
  var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/qq_weibo/t_add";
  $("#loading_pane").removeClass("hide");
		$.ajax({
			type: 'POST',
			url: strurl,
			data:{"qq_statuses_text":content},
			contentType: 'multipart/form-data',
			datatype: 'json',
			success:function(data)
			{ 
    $("#qq_user_timeline_tab a").trigger("click");
    $("#loading_pane").addClass("hide");
			},
			error:function(xhr,r,e)
			{
				alert(e);
    $("#loading_pane").addClass("hide");
			}
		});
}
