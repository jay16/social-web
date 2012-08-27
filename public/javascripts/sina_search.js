	$(function () {
			$("a[rel=pane_close]").click(function(e) {
					$("#details-pane").css("display","none");
		 	});
			$("a[rel=show_weibo]").click(function(e) {
			   $("#weibo_search").css("display","block");
			   $("#user_search").css("display","none");
				});
			$("a[rel=show_people]").click(function(e) {
			   $("#weibo_search").css("display","none");
			   $("#user_search").css("display","block");
			});
			$("#details-pane").css("height",$(window).height() - 70);
		
				$('input:text:first').focus();
			
//			$("#str_sel_mes").bind('keydown',function(e){
//				if(e.keyCode==13){
//					start_search()}
//		 		}); 
	});
	


<!--   weibo search --> 
	function weibo_search(){
		var txtq = $("#str_sel_mes").val();
		var filterori = $("#str_filter_ori").val();
		var filterpic = $("#str_filter_pic").val();
		var filtertime = $("#str_filter_time").val();
		//alert(filtertime);
		var strhost = window.location.host;
		var strprotocol = window.location.protocol;
		var strurl = strprotocol + "//" + strhost + "/sina_search/weibo_search_display"
		$.ajax({
			type: 'POST',
		    url: strurl,
		    data: {"strq":txtq,"strfilterori":filterori,"strfilterpic":filterpic,"strfiltertime":filtertime },
		    contentType: 'multipart/form-data',
		    datatype: 'json',
		    success:function(data)
		    {
		    	$("#weibo_search").html(data);
	    	 $("#user_search").css("display","none");
	    	 $("#weibo_search").css("display","block");
	    	 $('#loading_pane').addClass('hide');
		    },
		    error:function(xhr,r,e)
		    {
		    	$("#weibo_search").html("远方服务器没有响应，请稍候再试！<br/>" + e);
		    }
		  });
	};
<!--   user search --> 
 function user_search(){
		var strselect = $("#txtselect").val();
		if(strselect != ""){
				var strsintro = 0;
				var strsdomain = 0;
				var strgender = "n";
				var strprovince = $("#province").val();
				var strcity = $("#city").val();
				if($("#txtmes").attr('checked'))
					strsintro = 1;
				if($("#txtsdomain").attr('checked'))
					strsdomain = 1;
				if($("#man").attr('checked'))
					strgender = "m";
				if($("#woman").attr('checked'))
					strgender = "f";
		
				var strhost = window.location.host;
				var strprotocol = window.location.protocol;
				var strurl = strprotocol + "//" + strhost + "/sina_search/user_search_display"
				var strcode = 0
				$.ajax({
					type: 'POST',
					url: strurl,
					data: {
						"strselect":strselect,
						"strsintro":strsintro, 
						"strsdomain":strsdomain, 
						"strgender":strgender, 
						"strprovince":strprovince, 
						"strcity":strcity
					},
					contentType: 'multipart/form-data',
					datatype: 'json',
					success:function(data)
					{
						$("#user_search").html(data);
					 $("#user_search").css("display","block");
					 $("#weibo_search").css("display","none");
	    	$('#loading_pane').addClass('hide');
					},
					error:function(xhr,r,e)
					{
						alert(e);
					}
				});
		}
		else{
			alert("txtselect关键字不能为空")
		}
	 }



