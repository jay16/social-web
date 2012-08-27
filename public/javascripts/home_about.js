$(function(){
     $("p").hide();
     $(".article").css("overflow","auto");
     $('.toggle').click(function(){  
       if($("p:visible").length>=7)
          $("p").hide(1000);
        else{
				      $("p:hidden").show(1000);
				      $('.article').toggleClass("overflow-y");
         }
      });
      $('.km-info').click(function(){
       $p=$(this).find('p');
       if($p.is(":visible")) $p.hide();
       else                  $p.show();
      });
       
   /*
     $('.km-info').hover(
      function(){$(this).find('p').show();},
      function(){$(this).find('p').hide();}
      );   
   */   
    
  });  

