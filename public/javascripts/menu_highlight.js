 function setStyle(id){
   $(id).css({"font-size":"150%","color":"white"});
  }     
 var arr=location.pathname.split("/");
  //alert(arr[1]);
	switch(arr[1])
  {
   case "":
   case "home":
   case "home#":
				  switch(arr[2])
						  {
						   case "":      
								  setStyle("#topbar_index");
								  break;
						   case "about":      
								  setStyle("#topbar_about");
								  break;
								 default:
								 setStyle("#topbar_index");
						  }
						break;
				case "messages":
				  switch(arr[2])
				      {
				       case "timeline":
				       case "timeline#":      
						      setStyle("#topbar_weibo");
						      break;
				       case "select_message":
				       case "select_message#":      
						      setStyle("#topbar_search");
						      break;
				      }
      break;
				case "searching":
				  switch(arr[2])
				      {
				       case "timeline":
				       case "timeline#":      
						      setStyle("#topbar_weibo");
						      break;
				       case "rule_list":
				       case "rule_list#":      
						      setStyle("#topbar_search");
						      break;
				      }
      break;
     case "users":
								   switch(arr[2]){
								    case "sign_up":
								     setStyle("#topbar_registration");
								     break;
								    case "sign_in":
								     setStyle("#topbar_session");
								     break;
								    case "password":
								          switch(arr[3]){
								           case "new":
								            setStyle("#usr_registration");
								            break;
								           default:
								          }
								     break;
								    default:
								   }
      break;
   default:
  }
