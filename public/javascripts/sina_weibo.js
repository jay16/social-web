　
//写微博添加表情点击表情框时
function add_sina_emotion(mean){
		var content = $("#sina_statuses_text").val();
		content += mean;
		$("#sina_statuses_text").val(content);
}
//定位显示表情对话框位置
function sina_emotions(){
  $("#sina_emotions").toggleClass("hide");
 	var newPos = new Object();
  newPos.left= $("#sina_face").offset().left - 100;
  newPos.top= $("#sina_face").offset().top + 15;
  $("#sina_emotions").offset(newPos);
}
function sina_load_image(){
  $("#sina_statuses_image").toggleClass("hide");
 	var newPos = new Object();
  newPos.left= $("#sina_check_img").offset().left - 100;
  newPos.top= $("#sina_check_img").offset().top + 15;
  $("#sina_statuses_image").offset(newPos);
  $("#sina_img_tab_form").css("display","block")
  $("#load_img").attr("src","");
  $("#url_field").val("");
  $("#img_field").val("");
}
function readURL(input) {
  if (input.files && input.files[0]) {
     var reader = new FileReader();
     reader.onload = function (e) {                     
      $('#sina_load_img_pane').attr('src', e.target.result);
      $('#sina_load_img_pane').attr('width', "220");                
      } 
    reader.readAsDataURL(input.files[0]);             
   } 
}    
  //批量获取用户相关信息
		function sina_statuses_by_name(name){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/" + name;
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
      $("#loading_pane").addClass("hide");
					}
				});
		}
		//@到我的微博
		function sina_statuses_mentions(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/statuses_mentions";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
				   $("#loading_pane").addClass("hide");
					}
				});
		}
		//@到我的评论
		function sina_comments_mentions(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/comments_mentions";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
				   $("#loading_pane").addClass("hide");
					}
				});
		}
		//我发出的评论
		function sina_comments_by_me(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/comments_by_me";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
					}
				});
		}
		//我收到的评论
		function sina_comments_to_me(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/comments_to_me";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
				   $("#loading_pane").addClass("hide");
					}
				});
		}
		//我的关注
		function sina_my_friends(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/friends";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						alert(e);
				   $("#loading_pane").addClass("hide");
					}
				});
		}
		//我的粉丝
		function sina_my_followers(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/followers";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
      $("#loading_pane").addClass("hide");
					},
					error:function(xhr,r,e)
					{
						 alert(e);
				   $("#loading_pane").addClass("hide");
					}
				});
		}
		//我的收藏
		function sina_my_favorites(){
		  var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_weibo/favorites";
    $("#loading_pane").removeClass("hide");
				$.ajax({
					type: 'POST',
					url: strurl,
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#sina_curret_info_pane").html(data);
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
	function sina_statuses_update(content){
		var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/statuses_update";
		$("#loading_pane").removeClass("hide");
 	$.ajax({
  	type: 'POST',
    url: strurl,
   data: {"content":content},
   contentType: 'multipart/form-data',
   datatype: 'json',
   success:function(data)
   {
     $("#sina_user_timeline_tab a").trigger("click");
     $("#loading_pane").addClass("hide");
   },
   error:function(xhr,r,e)
   {
   	alert(e);
     $("#loading_pane").addClass("hide");
   }
 });
	}
	//发布其他用户信息为一条微博
	function statuses_update_userinfo(weiboid,content){
		var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/statuses_update";
		$("#loading_pane").removeClass("hide");
 	$.ajax({
  	type: 'POST',
    url: strurl,
   data: {"content":content},
   contentType: 'multipart/form-data',
   datatype: 'json',
   success:function(data)
   {
	   var after_success = "#"+String(weiboid)+"_after_pane"
	   $(after_success).toggleClass("alert-success");
	   $(after_success+" strong").html("Success!");
	   $(after_success+" span").html("微博发表成功!");
	   $(after_success).css("display","block");
	   $("#loading_pane").addClass("hide");
   },
   error:function(xhr,r,e)
   {
   	alert(e);
   }
 });
	}
//下载用户详细信息到本地
	function statuses_download(weiboid,content,screen_name){
		var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/statuses_download";
	   	$.ajax({
		   	type: 'POST',
		     url: strurl,
		    data: {"content":content,"screen_name":screen_name},
		    contentType: 'multipart/form-data',
		    datatype: 'json',
		    success:function(data)
		    {
				   var after_success = "#"+String(weiboid)+"_after_pane"
				   $(after_success).toggleClass("alert-success");
				   $(after_success+" strong").html("Success!");
				   $(after_success+" span").html(screen_name+"-详细信息成功下载到本地!");
				   $(after_success).css("display","block");
		    },
		    error:function(xhr,r,e)
		    {
		    	alert(e);
		    }
		  });
	}
	
//转发微博
	function sina_weibo_repost(weiboid,comment_content,comment_at_time){
		var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/repost";
	   	$.ajax({
					 type: 'POST',
				   url: strurl,
		    data: {"user_id":weiboid, "comment":comment_content, "is_comment":comment_at_time},
		    contentType: 'multipart/form-data',
		    datatype: 'json',
		    success:function(data)
		    {
		    },
		    error:function(xhr,r,e)
		    {
		    	alert(e);
		    }
		  });
	}
	//评论微博
	function weibo_comment_ajax(weiboid,comment_content,repost_at_time){
			var strhost = window.location.host;
			var strprotocol = window.location.protocol;
			var strurl = strprotocol + "//" + strhost + "/sina_weibo/comments_create";
			$("#loading_pane").removeClass("hide");
			$.ajax({
				type: 'POST',
					url: strurl,
				data: {"wbid":weiboid,"comment":comment_content,"is_repost":repost_at_time},
				contentType: 'multipart/form-data',
				datatype: 'json',
				success:function(data)
				{
				   var after_success = "#"+String(weiboid)+"_after_pane"
				   $(after_success).toggleClass("alert-success");
				   $(after_success+" strong").html("Success!");
				   $(after_success+" span").html("您的评论发表成功!");
				   $(after_success).css("display","block");
				   var list = "#"+String(weiboid)+"_comments_list"
				   $(list).prepend(data)
				   $("#loading_pane").addClass("hide");
				},
				error:function(xhr,r,e)
				{
					alert(e);
				}
		});
	}
	
		//获取评列表
	function comments_list(weiboid,is_reweeted){
			var strhost = window.location.host;
			var strprotocol = window.location.protocol;
			var strurl = strprotocol + "//" + strhost + "/sina_weibo/comments_list";
			$.ajax({
				type: 'POST',
					url: strurl,
				data: {"weibo_id":weiboid, "is_reweeted":is_reweeted},
				contentType: 'multipart/form-data',
				datatype: 'json',
				success:function(data)
				{
				   var list = "#"+String(weiboid)+"_comments_list"
				   $(list).html(data);
				},
				error:function(xhr,r,e)
				{
					alert(e);
				}
		});
	}
	//添加关注
	function friendship_create(userid){
	 var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/friendship_create"
		  	$.ajax({
		   	type: 'POST',
		     url: strurl,
		    data: {"user_id":userid},
		    contentType: 'multipart/form-data',
		    datatype: 'json',
		    success:function(data)
		    {
		     var friendship_pane = "#"+String(userid)+"_friendship_pane";
		    	$(friendship_pane).html(data);
		    },
		    error:function(xhr,r,e)
		    {
		    	alert(e);
		    }
		  });
	 
		 }
//取消关注
	function friendship_destroy(userid){
	 var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_weibo/friendship_destroy"
	   	$.ajax({
				 	type: 'POST',
				   url: strurl,
		    data: {"user_id":userid},
		    contentType: 'multipart/form-data',
		    datatype: 'json',
		    success:function(data)
		    {
		     var friendship_pane = "#"+String(userid)+"_friendship_pane";
		    	$(friendship_pane).html(data);
		    },
		    error:function(xhr,r,e)
		    {
		    	alert(e)
		    	
		    	//hideLoading();
		    }
		  });
		 }
